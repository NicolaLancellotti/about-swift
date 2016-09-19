//: [Previous](@previous)
/*:
 # Collection
 A sequence whose elements can be traversed multiple times, nondestructively, and accessed by indexed subscript.
 
 Collection inherits from Indexable that in turn inherits from IndexableBase.
 */
var collection = [1, 2, 3, 4]
//: ## IndexableBase
collection.startIndex
collection.endIndex  //the position one greater than the last valid subscript argument.

var anIndex = collection.startIndex
collection.formIndex(after: &anIndex) // Replaces the given index with its successor.

collection[1]
let slice = collection[1..<3]
//: The accessed slice uses the same indices for the same elements as the original collection uses.
slice.startIndex
slice.index(of: 3)
//: ## Indexable
collection.distance(from: 0, to: 2)
collection.formIndex(&anIndex, offsetBy: 10)
collection.formIndex(&anIndex, offsetBy: 10, limitedBy: 100)
collection.index(1, offsetBy: 2)
collection.index(1, offsetBy: 2, limitedBy: collection.endIndex)
//: ## Some Collection's Methods
collection.isEmpty
collection.count
collection.first

collection.prefix(upTo: 1)
collection.prefix(through: 1)
collection.suffix(from: 1)
//: A collection’s indices property can hold a strong reference to the collection itself, causing the collection to be non-uniquely referenced.
collection.indices
collection.index {
    $0 > -1
}

collection.removeFirst(2) // remove 1, 2
collection.removeFirst() // remove 3
collection
//: ## Conforming to the Collection Protocol
struct First10PrimeNumbers: Collection {
    
    private let primeNumbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
    
    // IndexableBase Conformance
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return primeNumbers.count
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(index: Int) -> Int {
        return primeNumbers[index]
    }
}

let primeNumbers = First10PrimeNumbers()
primeNumbers[9]

//: ## A collection whose elements are all identical.
let elements = repeatElement(1, count: 5)
elements.count
//: [Next](@next)
