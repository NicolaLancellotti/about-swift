//: [Previous](@previous)

//: # Able Protocols
struct SomeStructure {
    var value: Int = 0
}
let instance = SomeStructure()
/*:
 ## Equatable
 A type that can be compared for value equality.
 
 When adopting Equatable, only the == operator is required to be implemented. The standard library provides an implementation for !=.
 */
extension SomeStructure: Equatable {
    static func ==(lhs: SomeStructure, rhs: SomeStructure) -> Bool {
        return lhs.value == rhs.value
    }
}
/*:
Swift provides synthesized implementations of the equivalence operators for the following kinds of custom types:

* Structures that have only stored properties that conform to the Equatable protocol
* Enumerations that have only associated types that conform to the Equatable protocol
* Enumerations that have no associated types

 Declare Equatable conformance as part of the type’s original declaration to receive these default implementations.
*/
struct Point: Equatable {
    let x: Int
    let y: Int
}

Point(x: 0, y: 1) == Point(x: 0, y: 1)
/*:
 ## Hashable
 A type that provides an integer hash value.
 
 Inherits From Equatable
 */
extension SomeStructure: Hashable {
    var hashValue: Int {
        return value.hashValue
    }
}
/*:
 ## Comparable
 A type that can be compared using the relational operators <, <=, >=, and >.
 
 Inherits From Equatable
 
 A type conforming to Comparable need only supply the < and == operators; default implementations of <=, >, >=, and != are supplied by the standard library.
 */
extension SomeStructure: Comparable {
    
}

func <(lhs: SomeStructure, rhs: SomeStructure) -> Bool {
    return lhs.value < rhs.value
}
//: ### Function with comparable parameters
max(1, 2, 3)
min(1, 2, 3)
/*:
 ## Strideable
 Conforming types are notionally continuous, one-dimensional values that can be offset and measured.
 
 Inherits From Comparable
 */
extension SomeStructure: Strideable {
    func advanced(by n: Int) -> SomeStructure {
        return SomeStructure(value: self.value + n)
    }
    
    func distance(to other: SomeStructure) -> Int {
        return self.value - other.value
    }
}

let instance1 = SomeStructure(value: 1)
let instance2 = instance1.advanced(by: 1)
instance2.value
instance1.distance(to: instance2)
/*:
 ## RawRepresentable
 A type that can be converted to and from an associated raw value.
 */
struct SomeStructure1: RawRepresentable {
    var value: Int = 0
    init?(rawValue: String) {
        guard let value = Int(rawValue) else {
            return nil
        }
        self.value = value
    }
    
    var rawValue: String {
        return String(value)
    }
}

SomeStructure1(rawValue: "123")?.rawValue
//: [Next](@next)
