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
aCollection.indices

let lazyCollection: LazyCollection = aCollection.lazy
let lazyMapCollection: LazyMapCollection = lazyCollection.map {_ in }
lazyMapCollection.makeIterator()
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
aBidirectionalCollection.indices

let lazyBidirectionalCollection: LazyBidirectionalCollection = aBidirectionalCollection.lazy
lazyBidirectionalCollection.map {_ in }
lazyBidirectionalCollection.filter { _ in false }

aBidirectionalCollection.reversed()
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
aRandomAccessCollection.indices

let lazyRandomAccessCollection: LazyRandomAccessCollection = aRandomAccessCollection.lazy
lazyRandomAccessCollection.map {_ in }

aRandomAccessCollection.reversed()
/*:
 ## RangeReplaceableCollection
 Supports replacement of an arbitrary subrange of elements with the elements of another collection.
 
 Inherits From Collection.
 */
struct ARangeReplaceableCollection: RangeReplaceableCollection {
    
    private var storage = Array<Int>(repeating: 100, count: 0)
    
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
        return storage[position]
    }
    
    // RangeReplaceableCollection
    
    init() {
        
    }
    
    mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, C.Iterator.Element == Int {
        self.storage.replaceSubrange(subrange, with: newElements)
    }
}

let aRangeReplaceableCollection = ARangeReplaceableCollection()
/*:
 ## MutableCollection
 Supports subscript assignment.
 
 Inherits From Collection.
 */
struct AMutableCollection: MutableCollection {
    
    private var storage = Array<Int>(repeating: 100, count: 0)
    
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

let aMutableCollection = AMutableCollection()

/*:
 ## Slices
 * Slice
 * BidirectionalSlice
 * RandomAccessSlice
 
 
 * RangeReplaceableSlice
 * RangeReplaceableBidirectionalSlice
 * RangeReplaceableRandomAccessSlice
 
 
 * MutableSlice
 * MutableBidirectionalSlice
 * MutableRandomAccessSlice
 * MutableRangeReplaceableSlice
 * MutableRangeReplaceableBidirectionalSlice
 * MutableRangeReplaceableRandomAccessSlice
 */

//: ## Standard Library Collections
let allOne: Repeated = repeatElement(1, count: 5)
let only10 = CollectionOfOne(10)
let emptyCollection = EmptyCollection<Int>()

let flattenBidirectionalCollection: FlattenBidirectionalCollection = [0..<3, 8..<10, 15..<17].joined()
flattenBidirectionalCollection.startIndex























struct Number: Collection {
    
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

let numbers = Number()
numbers.underestimatedCount
numbers.count
numbers.isEmpty
let first: Int? = numbers.first
let indices: DefaultIndices = numbers.indices
numbers.endIndex
numbers.startIndex


numbers[1]
let slice: Slice = numbers[1...5]





numbers.distance(from: 10, to: 15)
numbers.dropFirst(10)
numbers.dropLast(10)
numbers.filter { $0 < 10}
numbers.first {$0 > 10 }


//numbers.formIndex(_:offsetBy:)
//numbers.formIndex(_:offsetBy:limitedBy:)
//numbers.formIndex(after:)

//numbers.index(_:offsetBy:)
//numbers.index(_:offsetBy:limitedBy:)
//numbers.index(after:) REQUIRED
let iterator: IndexingIterator = numbers.makeIterator()
numbers.map{ $0 }


//numbers.prefix(through:)
//numbers.prefix(upTo:)


numbers.suffix(from:1)


numbers.lazy



//numbers.last
//func reversed() -> ReversedCollection<Self>







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
let slice2 = collection[1..<3]
slice2.startIndex
slice2.index(of: 3)


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

//: [Next](@next)
