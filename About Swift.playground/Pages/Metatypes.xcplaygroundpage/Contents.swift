//: [Previous](@previous)
//: # Metatypes
enum Enumeration {}
struct Structure {}

protocol Initializable {
  init(value: Int)
}

protocol Requirements {
  func instanceMethod() -> Int
  static func staticMethod() -> Int
}

class Class: Initializable, Requirements {
  private let value: Int
  
  // Initializable
  required init(value: Int = 0) { self.value = value }
  
  // Requirements
  func instanceMethod() -> Int { self.value }
  static func staticMethod() -> Int { 0 }
}
/*:
 You can use the postfix postfix `self` expression to access a type as a value.
 */
do {
  let structMetatype: Structure.Type = Structure.self
  let enumMetatype: Enumeration.Type = Enumeration.self
}

do {
  let classMetatype: Class.Type = Class.self
  
  // The initializer must be marked with the required keyword or the entire class
  // marked with the final keyword.
  let instance: Class = classMetatype.init(value: 10)
  type(of: instance) == classMetatype
  
  classMetatype.instanceMethod(instance)()
  classMetatype.staticMethod()
}

do {
  let existentialMetatype: any (Initializable & Requirements).Type  = Class.self
  let existential: any Initializable & Requirements = existentialMetatype.init(value: 10)
  type(of: existential) == existentialMetatype
  
  existentialMetatype.staticMethod()
}

do {
  let protocolMetatype: (any Requirements).Type = (any Requirements).self
  let protocolMetatypeOldSyntax: Requirements.Protocol = Requirements.self
  protocolMetatype == protocolMetatypeOldSyntax
}
//: Any & AnyType
do {
  let existentialType:     /* any */ Any            = Class(value: 10)
  let existentialMetatype: /* any */ Any.Type       = Class.self
  let protocolMetatype:              (any Any).Type = Any.self
}
/*:
 ## Object identifier
 
 A unique identifier for a class instance or metatype.
 */
let instanceA1 = Class()
let instanceA2 = instanceA1
let instanceA3 = Class()

ObjectIdentifier(instanceA1) == ObjectIdentifier(instanceA2)
ObjectIdentifier(instanceA1) == ObjectIdentifier(instanceA3)

ObjectIdentifier(Class.self) == ObjectIdentifier(Class.self)
//: [Next](@next)
