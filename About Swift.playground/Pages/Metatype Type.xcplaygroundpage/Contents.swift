//: [Previous](@previous)

//: # Metatype Type

//: ## Protocol
protocol ProtocolA {}
ProtocolA.self // metatype type
//: ## Class
class ClassB {
    
}

class ClassA: ClassB {
 
    var data = 0
    
    override init() {
        
    }
    
    required init(data: Int) {
        
    }
    
    static func typeMethod() {
    }
    
    func instanceMethod() {
    }
}
let object = ClassA()
//: ## Type
object.self
//: ## Metatype
ClassA.self 
type(of: object)

let someInstance: ClassB = ClassA()
/*:
 ## Dynamic Type Expression
 
 The type(of:) expression evaluates to the value of the runtime type of the expression.
 */
type(of: someInstance) === ClassB.self
type(of: someInstance) === ClassA.self
//: ## Call Type Methods
ClassA.self.typeMethod()
ClassA.typeMethod()

type(of: object).typeMethod()
//: ## Call Instance Methods
object.self.instanceMethod()
object.instanceMethod()

var function = ClassA.self.instanceMethod(object)
function =  ClassA.instanceMethod(object)
function()
//: ## Initializers
ClassA.init(data: 1)
ClassA(data: 1)
//: For class instances, the initializer that’s called must be marked with the required keyword or the entire class marked with the final keyword.
type(of: object).init(data: 7)
//object.dynamicType(data: 5)       // Error

/*:
 ## Object Identifier
 
 A unique identifier for a class instance or metatype
 */
let instanceA1 = ClassA()
let instanceA2 = instanceA1
let instanceA3 = ClassA()

ObjectIdentifier(instanceA1) == ObjectIdentifier(instanceA2)
ObjectIdentifier(instanceA1) == ObjectIdentifier(instanceA3)

ObjectIdentifier(ClassA.self) == ObjectIdentifier(ClassB.self)

/*:
 ## Key-Path Expression
 
 A key-path expressions lets you access properties or subscript of a type dynamically
 
 They have the following form: ```\type name.path```
 
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
  so you can use it to access and change all of the data stored in a variable in a single step
 */

dic[keyPath: \.self] = ["key2" : [3]]
dic
//: [Next](@next)
