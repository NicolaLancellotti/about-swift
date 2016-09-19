//: [Previous](@previous)

/*:
 # Able Protocols
 * Equatable
 * Hashable
 * Comparable
 * Strideable
 * RawRepresentable
 * AbsoluteValuable
 * Streamable
 * IndexableBase
 * Indexable
 * MutableIndexable
 * BidirectionalIndexable
 * RandomAccessIndexable
 */
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
