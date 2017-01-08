//: [Previous](@previous)
/*:
 # Collection
 A sequence whose elements can be traversed multiple times, nondestructively, and accessed by indexed subscript.
 
 Collection Protocols:
 * __Collection__ -  Supports forward traversal.
 * __BidirectionalCollection__ - Supports backward and forward traversal.
 * __RandomAccessCollection__ - A collection that supports efficient random-access index traversal.
 
 
 * __MutableCollection__ - Supports subscript assignment.
 * __RangeReplaceableCollection__ - Supports replacement of an arbitrary subrange of elements with the elements of another collection.
 */
var collection = [1, 2, 3, 4]
//: ## Some Collection's Methods
collection.isEmpty
collection.count
collection.first

collection.prefix(upTo: 1)
collection.prefix(through: 1)
collection.suffix(from: 1)

/*:
 - important:
 A collection’s indices property can hold a strong reference to the collection itself, causing the collection to be non-uniquely referenced.
 */
collection.indices
collection.index {
    $0 > -1
}

collection.startIndex
collection.endIndex  //the position one greater than the last valid subscript argument.

var anIndex = collection.startIndex
collection.formIndex(after: &anIndex) // Replaces the given index with its successor.

collection.distance(from: 0, to: 2)
collection.formIndex(&anIndex, offsetBy: 10)
collection.formIndex(&anIndex, offsetBy: 10, limitedBy: 100)
collection.index(1, offsetBy: 2)
collection.index(1, offsetBy: 2, limitedBy: collection.endIndex)

collection[1]
/*:
 - important:
 The accessed slice uses the same indices for the same elements as the original collection uses.
 */
let slice = collection[1..<3]
slice.startIndex
slice.index(of: 3)


collection.removeFirst(2) // remove 1, 2
collection.removeFirst() // remove 3
collection

/*:
 When enumerating a collection, the integer part of each pair is a counter for the enumeration, not necessarily the index of the paired value. These counters can only be used as indices in instances of zero-based, integer-indexed collections, such as Array and ContiguousArray
 
 To iterate over the elements of a collection with its indices, use the zip(_:_:) function.
 */
let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
var shorterIndices: [SetIndex<String>] = []
for (i, name) in zip(names.indices, names) {
    if name.characters.count <= 5 {
        shorterIndices.append(i)
    }
}

for i in shorterIndices {
    print(names[i])
}
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
