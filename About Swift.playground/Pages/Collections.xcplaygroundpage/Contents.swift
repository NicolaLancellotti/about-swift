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
aCollection.indices
aCollection.startIndex
aCollection.endIndex //the position one greater than the last valid subscript argument.
aCollection.distance(from: 10, to: 15)

var anIndex = aCollection.startIndex
aCollection.formIndex(after: &anIndex) // Replaces the given index with its successor.
aCollection.formIndex(&anIndex, offsetBy: 10, limitedBy: 100)

aCollection.index(after: 10)
aCollection.index(10, offsetBy: 5, limitedBy: aCollection.endIndex)

aCollection.index(of: 10)
aCollection.index {$0 % 10 == 0}
//: ### Lazy
let lazyCollection: LazyCollection = aCollection.lazy
let lazyMapCollection: LazyMapCollection = lazyCollection.map {_ in }
let lazyMapIterator: LazyMapIterator = lazyMapCollection.makeIterator()
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
aBidirectionalCollection.reversed()

aBidirectionalCollection.indices
let lazyBidirectionalCollection: LazyBidirectionalCollection = aBidirectionalCollection.lazy
lazyBidirectionalCollection.map {_ in }
lazyBidirectionalCollection.filter { _ in false }
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
aRandomAccessCollection.reversed()

let lazyRandomAccessCollection: LazyRandomAccessCollection = aRandomAccessCollection.lazy
lazyRandomAccessCollection.map {_ in }
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
let allOne: Repeated = repeatElement(1, count: 5)
let only10 = CollectionOfOne(10)
let emptyCollection = EmptyCollection<Int>()

let flattenBidirectionalCollection: FlattenBidirectionalCollection = [0..<3, 8..<10, 15..<17].joined()
flattenBidirectionalCollection.startIndex


/*:
 ## Enumerate
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

names[shorterIndices[0]]
names[shorterIndices[1]]
//: [Next](@next)
