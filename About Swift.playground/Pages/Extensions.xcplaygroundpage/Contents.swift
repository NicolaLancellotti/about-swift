//: [Previous](@previous)
/*:
 # Extensions
 
 Extensions add new functionality to an existing:
 * class,
 * structure,
 * enumeration,
 * protocol.
 */
//: ## Extensions can:
//: Add computed properties and computed type properties
extension Double {
  var km: Double { self * 1_000.0 }
  var m: Double { self }
  var cm: Double { self / 100.0 }
  var mm: Double { self / 1_000.0 }
  var ft: Double { self / 3.28084 }
}

let marathon = 42.km + 195.m
//: Provide new convenience initializers
class Class {
  init() {
  }
}

extension Class {
  convenience init(value: Bool) {
    self.init()
  }
}
//: Define instance methods and type methods
extension Int {
  func repetitions(_ task: () -> Void) {
    for _ in 0..<self {
      task()
    }
  }
}

3.repetitions {
  print("Goodbye!")
}
//: Define subscripts
extension Int {
  subscript(digitIndex: Int) -> Int {
    var decimalBase = 1
    for _ in 0..<digitIndex {
      decimalBase *= 10
    }
    return (self / decimalBase) % 10
  }
}

let value = 1983
value[0]
value[1]
value[2]
value[3]
//: Define and use new nested types
extension Int {
  enum Kind {
    case negative, zero, positive
  }
  
  var kind: Kind {
    switch self {
      case 0: .zero
      case let x where x > 0: .positive
      default: .negative
    }
  }
}
/*:
 ### Make an existing type conform to a protocol
 
 If a type already conforms to all of the requirements of a protocol, but has
 not yet stated that it adopts that protocol, you can make it adopt the protocol
 with an empty extension.
 */
protocol FooProtocol {
  func foo() -> String
}

struct Struct {
  func foo() -> String { "" }
}

extension Struct: FooProtocol {}
/*:
 ## Protocol extensions
 
 You can use protocol extensions to provide a default implementation to any
 method or property requirement of that protocol. If a conforming type provides
 its own implementation of a required method or property, that implementation
 will be used instead of the one provided by the extension.
 */
/*:
 - important:
 For non-required methods or properties, static dispaching is performed.
 */
protocol ProtocolWithExtension {
  func requiredMethod1() -> String
  func requiredMethod2() -> String
}

extension ProtocolWithExtension {
  func requiredMethod1() -> String { "ProtocolWithExtension - requiredMethod1" }
  func requiredMethod2() -> String { "ProtocolWithExtension - requiredMethod2" }
  
  // Non-required method
  func  nonRequiredMethod() -> String { "ProtocolWithExtension - bar" }
}

struct Structure: ProtocolWithExtension {
  func requiredMethod1() -> String { "Structure - requiredMethod1" }
  func nonRequiredMethod() -> String { "Structure - nonRequiredMethod" }
}

do {
  let instance = Structure()
  instance.requiredMethod1()
  instance.requiredMethod2()
  instance.nonRequiredMethod()
}

do {
  let instance: any ProtocolWithExtension = Structure()
  instance.requiredMethod1()
  instance.requiredMethod2()
  instance.nonRequiredMethod() // static dispaching
}
//: ### Generic where clauses
extension ProtocolWithExtension where Self: FooProtocol {
  var baz: String {
    self.requiredMethod1() + " + " + self.foo()
  }
}

extension Structure: FooProtocol {
  func foo() -> String { "Structure - foo" }
}

Structure().baz
//: [Next](@next)
