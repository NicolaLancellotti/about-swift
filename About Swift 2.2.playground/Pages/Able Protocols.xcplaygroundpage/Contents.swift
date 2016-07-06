//: [Previous](@previous)
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
    
}

func ==(lhs: SomeStructure, rhs: SomeStructure) -> Bool {
    return lhs.value == rhs.value
}

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
//: [Next](@next)