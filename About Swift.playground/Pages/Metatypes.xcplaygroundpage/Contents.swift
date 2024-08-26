//: [Previous](@previous)
//: # Metatypes
protocol Protocol1 {}
protocol Protocol2 {}

class Class: Protocol1, Protocol2 {
  required init(x: Int = 0) {}
  static func staticMethod() {}
  func instanceMethod(flag: Bool) -> Bool { !flag }
}

struct Structure {}

enum Enumeration {}
/*:
 You can use the postfix postfix `self` expression to access a type as a value.
 */
let _: Class.Type        /* class metatype  */ = Class.self
let _: Structure.Type    /* struct metatype */ = Structure.self
let _: Enumeration.Type  /* enum metatype   */ = Enumeration.self

let _: Protocol1.Protocol   /* protocol metatype */ = Protocol1.self
let _: (any Protocol1).Type /* protocol metatype */ = (any Protocol1).self

let _: any Protocol1.Type /* existential metatype */ = Class.self
let _: any (Protocol1 & Protocol2).Type              = Class.self
//: Call Instance Methods
let classType: Class.Type = Class.self
// The initializer must be marked with the required keyword or the entire class
// marked with the final keyword.
classType.init(x: 10)

classType.instanceMethod(Class(x: 10))(flag: true)
classType.staticMethod()
//: Access an instance’s dynamic runtime type as a value
let instance: Class = Class(x: 0)
let _: Class.Type = type(of: instance)

let existential: any Protocol1 = instance
let _: any Protocol1.Type = type(of: existential)
//: Any & AnyType
let _: /* any */ Any      /* existential type     */ = 1
let _: /* any */ Any.Type /* existential metatype */ = Int.self
let _: (any Any).Type     /* protocol metatype    */ = Any.self
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
