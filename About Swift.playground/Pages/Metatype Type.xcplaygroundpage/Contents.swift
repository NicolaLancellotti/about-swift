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
//: ### Type
object.self
//: ### Metatype
ClassA.self 
type(of: object)

let someInstance: ClassB = ClassA()
/*:
 ### Dynamic Type Expression
 
 The type(of:) expression evaluates to the value of the runtime type of the expression.
 */
type(of: someInstance) === ClassB.self
type(of: someInstance) === ClassA.self
//: ### Call Type Methods
ClassA.self.typeMethod()
ClassA.typeMethod()

type(of: object).typeMethod()
//: ### Call Instance Methods
object.self.instanceMethod()
object.instanceMethod()

var function = ClassA.self.instanceMethod(object)
function =  ClassA.instanceMethod(object)
function()
//: ### Initializers
ClassA.init(data: 1)
ClassA(data: 1)
//: For class instances, the initializer that’s called must be marked with the required keyword or the entire class marked with the final keyword.
type(of: object).init(data: 7)
//object.dynamicType(data: 5)       // Error
//: [Next](@next)
