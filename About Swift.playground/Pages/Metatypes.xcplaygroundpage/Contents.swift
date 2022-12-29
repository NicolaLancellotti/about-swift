//: [Previous](@previous)
//: # Metatypes
protocol AProtocol {}
protocol AProtocol2 {}

class AClass: AProtocol, AProtocol2 {
  required init(x: Int = 0) {}
  static func staticMethod() {}
  func instanceMethod(flag: Bool) -> Bool { !flag }
}

struct AStruct {}

enum AnEnum {}
/*:
 You can use the postfix postfix `self` expression to access a type as a value.
 */
let _: AClass.Type          /* class metatype       */ = AClass.self
let _: AStruct.Type         /* struct metatype      */ = AStruct.self
let _: AnEnum.Type          /* enum metatype        */ = AnEnum.self

let _: any AProtocol.Type   /* existential metatype */ = AClass.self
let _: any (AProtocol & AProtocol2).Type               = AClass.self

let _: (any AProtocol).Type /* protocol metatype    */ = (any AProtocol).self
let _: AProtocol.Protocol   /* protocol metatype    */ = AProtocol.self
//: Call Instance Methods
let aClass: AClass.Type = AClass.self
// The initializer must be marked with the required keyword or the entire class marked with the final keyword.
aClass.init(x: 10)

aClass.instanceMethod(AClass(x: 10))(flag: true)
aClass.staticMethod()
//: Access that instance’s dynamic, runtime type as a value.
let instance: AClass = AClass(x: 0)
let aClass2: AClass.Type = type(of: instance)

let existential: any AProtocol = instance
let _: any AProtocol.Type = type(of: existential)
//: Any & AnyType
let _: /* any */ Any      /* existential type     */ = 1
let _: /* any */ Any.Type /* existential metatype */ = Int.self
let _: (any Any).Type     /* protocol metatype    */ = Any.self
/*:
 ## Object Identifier
 
 A unique identifier for a class instance or metatype.
 */
let instanceA1 = AClass()
let instanceA2 = instanceA1
let instanceA3 = AClass()

ObjectIdentifier(instanceA1) == ObjectIdentifier(instanceA2)
ObjectIdentifier(instanceA1) == ObjectIdentifier(instanceA3)

ObjectIdentifier(AClass.self) == ObjectIdentifier(AClass.self)
/*:
 ## Key-Path Expression
 
 A key-path expressions lets you access properties or subscript of a type dynamically.
 
 They have the following form: `\type name.path`.
 
 The type name can be omitted in contexts where type inference can determine the implied type.
 */
var dic: [String : [Int]] = ["key" : [1, 2]]
let keyPath1 = \[String : [Int]].["key"]
let keyPath2 = \[String : [Int]].["key"]?.count
let keyPath3 = \[String : [Int]].["key"]?[0]
dic[keyPath: keyPath1]
dic[keyPath: keyPath2]
dic[keyPath: keyPath3]
/*:
 The path can refer to self to create the identity key path (\.self). The identity key path refers to a whole instance,
 so you can use it to access and change all of the data stored in a variable in a single step.
 */
dic[keyPath: \.self] = ["key2" : [3]]
dic
/*:
 ### Key Path Expressions as Functions
 
 A `\Root.value` key path expression is now allowed wherever a `(Root) -> Value` function is allowed.
 */
struct AnotherStruct {
  let data: Int
}

let array = [AnotherStruct(data: 0), AnotherStruct(data: 1)]
var mapped = array.map(\.data)

mapped = array.map { $0[keyPath: \AnotherStruct.data]}
mapped

mapped = array.map { $0.data }
mapped
//: [Next](@next)
