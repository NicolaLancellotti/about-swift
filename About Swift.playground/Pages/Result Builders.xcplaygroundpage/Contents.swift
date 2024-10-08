//: [Previous](@previous)
//: # Result Builders
//: ### Utility
enum ToyLangError: Error {
  case variableNotFound(String)
  case evaluateNotFound
}

class Environment {
  private var dic = [String: Int]()
  
  func set(_ variable: String, to value: Int) {
    dic[variable] = value
  }
  
  func get(_ variable: String) throws -> Int {
    guard let value = dic[variable] else {
      throw ToyLangError.variableNotFound(variable)
    }
    return value
  }
}
//: ### Nodes
protocol Expr {
  @discardableResult
  func eval(_ environment: Environment) throws -> Int
}


struct Number: Expr {
  let value: Int
  
  init(_ value: Int) {
    self.value = value
  }
  
  func eval(_ environment: Environment) throws -> Int {
    value
  }
}

struct Var: Expr {
  let name: String
  
  init(_ name: String) {
    self.name = name
  }
  
  func eval(_ environment: Environment) throws -> Int {
    try environment.get(name)
  }
}

struct SetVar: Expr {
  let variable: Var
  let expression: any Expr
  
  init(_ variable: Var, to expression: any Expr) {
    self.variable = variable
    self.expression = expression
  }
  
  func eval(_ environment: Environment) throws -> Int {
    let value = try expression.eval(environment)
    environment.set(variable.name, to: value)
    return value
  }
}

struct BinaryOp: Expr {
  enum Operator {
    case plus
    case minus
  }
  
  let lhs: any Expr
  let op: Operator
  let rhs: any Expr
  
  init(_ lhs: any Expr, _ op: Operator, _ rhs: any Expr) {
    self.lhs = lhs
    self.op = op
    self.rhs = rhs
  }
  
  func eval(_ environment: Environment) throws -> Int {
    let lhsValue = try lhs.eval(environment)
    let rhsValue = try rhs.eval(environment)
    return switch op {
      case .minus: lhsValue - rhsValue
      case .plus: lhsValue + rhsValue
    }
  }
}

struct Eval: Expr {
  let variable: Var
  
  init(_ variable: Var) {
    self.variable = variable
  }
  
  func eval(_ environment: Environment) throws -> Int {
    try environment.get(variable.name)
  }
}
//: ## Result builder
@resultBuilder
enum ToyLangBuilder {
  typealias Expression = Expr
  typealias Component = [Expr]
  typealias FinalResult = Result<Int, ToyLangError>
  
  static func buildExpression(_ element: Expression) -> Component {
    [element]
  }
  
  static func buildExpression(_ element: Void) -> Component {
    []
  }
  
  static func buildOptional(_ component: Component?) -> Component {
    component ?? []
  }
  
  static func buildEither(first component: Component) -> Component {
    component
  }
  
  static func buildEither(second component: Component) -> Component {
    component
  }
  
  static func buildArray(_ components: [Component]) -> Component {
    components.flatMap { $0 }
  }
/*:
 A Result Builder is required to have either at least one static buildBlock
  method, or both buildPartialBlock(first:) and buildPartialBlock(accumulated:next:)
 */
//  static func buildBlock(_ components: Component...) -> Component {
//    components.flatMap { $0 }
//  }
  
  static func buildPartialBlock(first: Component) -> Component {
    first
  }
  
  static func buildPartialBlock(accumulated: Component, next: Component) -> Component {
    accumulated + next
  }
  
  static func buildFinalResult(_ component: Component)  -> FinalResult {
    Result {
      guard let result = component.last as? Eval else {
        throw ToyLangError.evaluateNotFound
      }
      
      let environment = Environment()
      for expr in component {
        try expr.eval(environment)
      }
      return try result.eval(environment)
    }.mapError { $0 as! ToyLangError}
  }
}
//: ## Result-builder attributes
//: ### On closures
func eval(@ToyLangBuilder closure: () -> ToyLangBuilder.FinalResult) -> ToyLangBuilder.FinalResult {
  closure()
}

let value1 = eval {
  let x = Var("x")
  SetVar(x, to: Number(0))
  for i in 1...2 {
    SetVar(x, to: BinaryOp(x, .plus, Number(i)))
  }
  Eval(x)
}
value1
//: ### On functions
@ToyLangBuilder
func eval(increase: Bool, minus: Bool) -> ToyLangBuilder.FinalResult {
  let x = Var("x")
  SetVar(x, to: Number(0))
  
  if increase {
    SetVar(x, to: BinaryOp(x, .plus, Number(1)))
  }
  
  if minus {
    SetVar(x, to: BinaryOp(x, .minus, Number(2)))
  } else {
    SetVar(x, to: BinaryOp(x, .plus, Number(2)))
  }
  
  Eval(x)
}

let value2 = eval(increase: true, minus: true)
value2
//: ### Variable or subscript declaration that includes a getter
@ToyLangBuilder
var value3: ToyLangBuilder.FinalResult {
  let x = Var("x")
  SetVar(x, to: Number(1))
  Eval(x)
}
value3
//: [Next](@next)
