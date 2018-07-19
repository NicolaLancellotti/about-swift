//: [Previous](@previous)
import Foundation
//: # Copy of Value Type with Referece Type properties

class MyType: NSObject, NSCopying {
    var value = 0
    
    init(value: Int) {
        self.value = value
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return MyType(value: value)
    }
}

struct Wrapper {
    private var object = MyType(value: 0)
    
    private var objectForReading: MyType {
        return object
    }
    
    private var objectForWriting: MyType {
        mutating get {
            if !isKnownUniquelyReferenced(&object) {
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
