//: [Previous](@previous)
import Foundation
//: # Copying
class MyType: NSObject, NSCopying {
    var value = 0
    
    init(value: Int) {
        self.value = value
    }
    
    @objc func copyWithZone(zone: NSZone) -> AnyObject {
        return MyType(value: value)
    }
}
/*:
 ## @NSCopying
 This attribute causes the property’s setter to be synthesized with a copy of the property’s value.
 
 Apply this attribute to a stored variable property of a class. This attribute causes the property’s setter to be synthesized with a copy of the property’s value—returned by the copyWithZone(_:) method—instead of the value of the property itself. The type of the property must conform to the NSCopying protocol.
 
 */
class ClassWithObjectMyType {
    @NSCopying var objectMyType: MyType?
}

let myType = MyType(value: 10)
let instance = ClassWithObjectMyType()
instance.objectMyType = myType
instance.objectMyType?.value

myType.value = 11
instance.objectMyType?.value
//: ## Value Type with Referece Type property
struct Wrapper {
    private var object = MyType(value: 0)
    
    private var objectForReading: MyType {
        return object
    }
    
    private var objectForWriting: MyType {
        mutating get {
            if !isUniquelyReferencedNonObjC(&object) {
                object = object.copy() as! MyType
            }
            return object
        }
    }
    
    var value: Int {
        set {
            objectForWriting.value = newValue
        }
        get {
            return objectForReading.value
        }
    }
}

var aWrapper1 = Wrapper()
var aWrapper2 = aWrapper1

aWrapper1.value = 10
aWrapper2.value = 20

aWrapper1.value // 10
aWrapper2.value // 20
/*:
 - important:
 if you use `objectForReading` in the set of the computed property `value` then `aWrapper1.value` and `aWrapper2.value` will be both equal to 20
 */

//: [Next](@next)
