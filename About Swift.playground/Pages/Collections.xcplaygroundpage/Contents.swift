//: [Previous](@previous)
/*:
 # Collections
 A collection is a sequence whose elements can be traversed multiple times, nondestructively, and accessed by indexed subscript.
 */

/*: 
 ## Collection
 Supports forward traversal.
 */
struct ACollection: Collection {
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return 100
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(position: Int) -> Int {
        return position
    }
}

let aCollection = ACollection()

aCollection.isEmpty
aCollection.count
aCollection.underestimatedCount
aCollection.first
aCollection[10]
//: ### Indices
/*:
 - important:
 A collection’s indices property can hold a strong reference to the collection itself, causing the collection to be non-uniquely referenced.
 */
let indices: DefaultIndices = aCollection.indices
aCollection.startIndex
aCollection.endIndex //the position one greater than the last valid subscript argument.
aCollection.distance(from: 10, to: 15)

var anIndex = aCollection.startIndex
aCollection.formIndex(after: &anIndex) // Replaces the given index with its successor.
aCollection.formIndex(&anIndex, offsetBy: 10, limitedBy: 100)

aCollection.index(after: 10)
aCollection.index(10, offsetBy: 5, limitedBy: aCollection.endIndex)

aCollection.firstIndex(of: 10)
aCollection.firstIndex {$0 % 10 == 0}
//: ### Lazy
let lazyCollection: LazyCollection = aCollection.lazy
let lazyMapCollection: LazyMapCollection = lazyCollection.map {_ in }
let lazyMapIterator = lazyMapCollection.makeIterator()
let lazyFilterCollection: LazyFilterCollection = lazyCollection.filter { _ in false }
lazyFilterCollection.startIndex
/*:
 ## BidirectionalCollection
 Supports backward and forward traversal.
 
 Inherits From Collection.
 */
struct ABidirectionalCollection: BidirectionalCollection {
    
    // Collection
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return 100
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(position: Int) -> Int {
        return position
    }
    
    // BidirectionalCollection
    
    func index(before i: Int) -> Int {
        return i - 1
    }
}

let aBidirectionalCollection = ABidirectionalCollection()

aBidirectionalCollection.last

let reversedCollection: ReversedCollection = aBidirectionalCollection.reversed()

/*:
 - note:
 The reversed() method is always lazy when applied to a collection with bidirectional indices, but does not implicitly confer laziness on algorithms applied to its result.
 */

/*:
 ## RandomAccessCollection
 
 Supports efficient random-access index traversal.
 
 Inherits From RandomAccessCollection.
 */
struct ARandomAccessCollection: RandomAccessCollection {
    
    // Collection
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return 100
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(position: Int) -> Int {
        return position
    }
    
    // BidirectionalCollection
    
    func index(before i: Int) -> Int {
        return i - 1
    }
    
    // RandomAccessCollection
    // Either index is conform to the Strideable
    // or you must implement:
    
    func index(_ i: Int, offsetBy n: Int) -> Int {
        return i + n
    }
    
    func distance(from start: Int, to end: Int) -> Int {
        return end - start
    }
    
    // In this case index (Int) already complied to Strideable
}

let aRandomAccessCollection = ARandomAccessCollection()

let randomReversedCollection: ReversedCollection = aRandomAccessCollection.reversed()
/*:
 ## RangeReplaceableCollection
 Supports replacement of an arbitrary subrange of elements with the elements of another collection.
 
 Inherits From Collection.
 */
struct ARangeReplaceableCollection: RangeReplaceableCollection {
    
    private var storage = [Int]()
    
    // Collection
    var startIndex: Int {
        return storage.startIndex
    }
    
    var endIndex: Int {
        return storage.endIndex
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(position: Int) -> Int {
        return storage[position]
    }
    
    // RangeReplaceableCollection
    
    init() {
        
    }
    
    mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, C.Iterator.Element == Int {
        self.storage.replaceSubrange(subrange, with: newElements)
    }
}

var aRangeReplaceableCollection = ARangeReplaceableCollection()
aRangeReplaceableCollection.reserveCapacity(15)

aRangeReplaceableCollection.count
aRangeReplaceableCollection.append(4)
aRangeReplaceableCollection.append(contentsOf: [5, 6, 7, 8])
aRangeReplaceableCollection.insert(contentsOf: [2, 3], at: 0)
aRangeReplaceableCollection.insert(1, at: 0)
Array(aRangeReplaceableCollection)


aRangeReplaceableCollection.replaceSubrange(0...2, with: [0])

aRangeReplaceableCollection.removeFirst()
aRangeReplaceableCollection.remove(at: 0)
aRangeReplaceableCollection.removeSubrange(0...2)
aRangeReplaceableCollection.removeAll { $0 > 10 }
aRangeReplaceableCollection.removeAll()
/*:
 - note:
 If the collection is also a BidirectionalCollection there is also removeLast() method.
 */

/*:
 ## MutableCollection
 Supports subscript assignment.
 
 Inherits From Collection.
 */
struct AMutableCollection: MutableCollection {
    
    private var storage = [1, 3, 6, 2]
    
    // Collection
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return 100
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(position: Int) -> Int {
        get {
            return storage[position]
        }
        // MutableCollection
        set {
            storage[position] = newValue
        }
    }
}

var aMutableCollection = AMutableCollection()
aMutableCollection[0]
aMutableCollection[0] = 100
aMutableCollection[0]

aMutableCollection[0]
aMutableCollection[1]
aMutableCollection.swapAt(0, 1)
aMutableCollection[0]
aMutableCollection[1]

/*:
 ## Slices
 */

/*:
 - important:
 The accessed slice uses the same indices for the same elements as the original collection uses.
 */
aCollection[1...3]

aCollection.prefix(upTo: 10)
aCollection.prefix(through: 10)

aCollection.suffix(from: 10)
aCollection.suffix(10)

Array(aMutableCollection[2..<4])
aMutableCollection[2..<4].sorted()
//: ## Standard Library Collections

/*: 
 ### Array
 An ordered, random-access collection.
 */
// Creating an Empty Array
var array1 = Array<Int>()
var array2 = [Int]() // Array Type Shorthand Syntax

// Creating Array with a Default Value
var array3 = [Int](repeating: 10, count: 2)

// Creating Array by Adding Two Arrays Together
var array4 = array3 + array3

// Creating an Array with an Array Literal
var array5 = [1, 2]

// Remove all Elements
array5 = [] // array5 is now an empty array
/*: 
 ### Set
 An unordered collection of unique elements.
 
 The elements mush be hashable.
 */
// Creating an Empty Set
var set1 = Set<Int>()
// Creating a Set with an Array Literal
var set2: Set = [1, 2, 3]
// Remove all Elements
set2 = [] // set2 is now an empty set
/*:
 - note:
 See SetAlgebra for other set operations
*/
set1.startIndex
set1.makeIterator()
/*: 
 ### Dictionary
 An **unordered** collection whose elements are key-value pairs.
 
 The key mush be hashable.
 */
// Creating an Empty Dictionary
var dictionary1 = Dictionary<Int, String>()
var dictionary2 = [Int: String]() // Dictionary Type Shorthand Syntax

// Creating a Dictionary with a Dictionary Literal
var dictionary3 = [1 : "apple", 2 : "banana"]
dictionary3[1]
dictionary3[1] = nil
dictionary3[1]

// Remove all Elements
dictionary2 = [:] // // array5 is now an empty dictionary

dictionary1.startIndex
dictionary1.makeIterator()

// Creating a Dictionary with a Sequence
let pairsWithoutDuplicateKeys = [(1, "Name1"), (2, "Name2")]
Dictionary(uniqueKeysWithValues: pairsWithoutDuplicateKeys)

// Grouping
struct Item {
    var key: Int
    var data: String
}

let items = [
    Item(key: 1, data: "Name1"),
    Item(key: 1, data: "Name2"),
    Item(key: 2, data: "Name3")
]

let itemsByKey = Dictionary(grouping: items) { $0.key }
itemsByKey[1]
itemsByKey[2]

// Merging initializers and methods

let pairsWithDuplicateKeys = [("a", 1), ("b", 2), ("a", 3), ("b", 4)]
let firstValues = Dictionary(pairsWithDuplicateKeys,
                             uniquingKeysWith: { (first, _) in first })

var dictionary4 = ["a": 1, "b": 2]
dictionary4.merge(["a": 3, "c": 4]) { (current, _) in current }

// Key-based subscript with default value
let dictionary5 = [Int: String]()
dictionary5[1, default: "Hello"]

// Map Values
let keysCount = itemsByKey.mapValues {$0.count}
keysCount[1]
keysCount[2]

// Compact Map Values
let values = ["a": "1", "b": "Z"].compactMapValues(Int.init)
values["a"]
values["b"]
/*: 
 ### KeyValuePairs
 An **ordered** collection whose elements are key-value pairs.
 
 Some operations that are efficient on a dictionary are slower when using KeyValuePairs
 
 KeyValuePairs also allows duplicates keys.
 */
let keyValuePairs: KeyValuePairs = [1 : "a", 1 : "b"]
keyValuePairs.first!.key
keyValuePairs.first!.value
//: When calling a function with a KeyValuePairs parameter, you can pass a Swift dictionary literal without causing a Dictionary to be created
struct IntPairs {
    var elements: [(Int, Int)]
    
    init(_ elements: KeyValuePairs<Int, Int>) {
        self.elements = Array(elements)
    }
}

let pairs = IntPairs([1: 2, 1: 1, 3: 4, 2: 1])
pairs.elements
/*:
 ### ContiguousArray
 
 ContiguousArray always stores its elements in a contiguous region of memory.
 
 Array store its elements in a
 * contiguous region of memory - if its `Element` type is a value type
 * NSArray - if its `Element` type is a class or @objc protocol
 
 
 If your array's Element type is a class or @objc protocol and you do not need to bridge the array to NSArray or pass the array to Objective-C APIs, using ContiguousArray may be more efficient and have more predictable performance than Array.
 
 */
class SomeClass {
    
}

let contiguousArray = ContiguousArray<SomeClass>()
//: ### Other
let allOne: Repeated = repeatElement(1, count: 5)
let only10 = CollectionOfOne(10)
let emptyCollection = EmptyCollection<Int>()

let flattenBidirectionalCollection: FlattenCollection = [0..<3, 8..<10, 15..<17].joined()
flattenBidirectionalCollection.startIndex

// ArraySlice is a slice of an Array, ContiguousArray, or ArraySlice instance.
array1.prefix(2)
/*:
 ## Enumerate
 When enumerating a collection, the integer part of each pair is a counter for the enumeration, not necessarily the index of the paired value. These counters can only be used as indices in instances of zero-based, integer-indexed collections, such as Array and ContiguousArray
 
 To iterate over the elements of a collection with its indices, use the zip(_:_:) function.
 */
let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
var shorterIndices: [SetIndex<String>] = []
for (i, name) in zip(names.indices, names) {
    if name.count <= 5 {
        shorterIndices.append(i)
    }
}

names[shorterIndices[0]]
names[shorterIndices[1]]
//: [Next](@next)
