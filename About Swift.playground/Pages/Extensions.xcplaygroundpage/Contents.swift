//: [Previous](@previous)
/*:
 # Extensions
 
 Extensions add new functionality to an existing:
 * class.
 * structure.
 * enumeration.
 * protocol.
 */
//: ## Extensions in Swift can:
//: ### Add computed properties and computed type properties
extension Double {
  var km: Double { self * 1_000.0 }
  var m: Double { self }
  var cm: Double { self / 100.0 }
  var mm: Double { self / 1_000.0 }
  var ft: Double { self / 3.28084 }
}

let aMarathon = 42.km + 195.m
//: ### Provide new convenience initializers.
class SomeClass {
  init() {
  }
}

extension SomeClass {
  convenience init(value: Bool) {
    self.init()
  }
}
//: ### Define instance methods and type methods
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
//: ### Define subscripts
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
//: ### Define and use new nested types
extension Int {
  
  enum Kind {
    case negative, zero, positive
  }
  
  var kind: Kind {
    switch self {
      case 0:
        return .zero
      case let x where x > 0:
        return .positive
      default:
        return .negative
    }
  }
  
}
/*:
 ### Make an existing type conform to a protocol
 
 If a type already conforms to all of the requirements of a protocol, but has not yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension.
 */
protocol SomeProtocol {
  func foo()
}

struct SomeType {
  func foo() {
  }
}

extension SomeType: SomeProtocol {
  
}
/*:
 ## Protocol Extensions
 
 You can use protocol extensions to provide a default implementation to any method or property requirement of that protocol. If a conforming type provides its own implementation of a required method or property, that implementation will be used instead of the one provided by the extension.
 */
/*:
 - important:
 For no required method or property, static dispaching is performed.
 */
protocol AProtocol {
  
  func foo() -> String
  func fubar() -> String
  
}

extension AProtocol {
  
  func foo() -> String {
    "AProtocol - foo"
  }
  
  func fubar() -> String {
    "AProtocol - fubar"
  }
  
  // No required method
  func bar() -> String {
    "AProtocol - bar"
  }
}

struct AStructure: AProtocol {
  
  func foo() -> String {
    "AStructure - foo"
  }
  
  func bar() -> String {
    "AStructure - bar"
  }
}

let instace = AStructure()
instace.foo()
instace.fubar()
instace.bar()

let anotherInstace: any AProtocol = AStructure()
anotherInstace.foo()
anotherInstace.fubar()
anotherInstace.bar() // static dispaching
//: ### Generic Where Clauses
protocol Baz {
  var baz: Int { get }
}

extension AProtocol where Self: Baz {
  var indirectBaz: Int { baz }
}

extension AStructure: Baz {
  var baz: Int { 10 }
}

AStructure().indirectBaz
//: [Next](@next)
