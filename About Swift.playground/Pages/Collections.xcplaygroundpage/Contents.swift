//: [Previous](@previous)
/*:
 # Collections
 
 A collection is a sequence whose elements can be traversed multiple times,
 nondestructively, and accessed by indexed subscript.
 */
/*: 
 ## Collection
 
 Supports forward traversal.
 */
struct MyCollection: Collection {
  var startIndex: Int { 0 }
  
  var endIndex: Int { 100 }
  
  func index(after i: Int) -> Int { i + 1 }
  
  subscript(position: Int) -> Int { position }
}

do {
  let collection = MyCollection()
  collection.isEmpty
  collection.count
  collection.underestimatedCount
  collection.first
  collection[10]
}
//: ### Indices
/*:
 - important:
 A collection’s indices property can hold a strong reference to the collection
 itself, causing the collection to be non-uniquely referenced.
 */
do {
  let collection = MyCollection()
  let indices: DefaultIndices = collection.indices
  collection.startIndex
  collection.endIndex //the position one greater than the last valid subscript argument.
  collection.distance(from: 10, to: 15)
  
  var index = collection.startIndex
  collection.formIndex(after: &index) // Replaces the given index with its successor.
  collection.formIndex(&index, offsetBy: 10, limitedBy: 100)
  
  collection.index(after: 10)
  collection.index(10, offsetBy: 5, limitedBy: collection.endIndex)
  
  collection.firstIndex(of: 10)
  collection.firstIndex {$0 % 10 == 0}
}
//: ### Lazy
do {
  let collection = MyCollection()
  let lazyCollection: LazyCollection = collection.lazy
  let lazyMapCollection: LazyMapCollection = lazyCollection.map { _ in }
  let lazyMapIterator = lazyMapCollection.makeIterator()
  let lazyFilterCollection: LazyFilterCollection = lazyCollection.filter { _ in false }
  lazyFilterCollection.startIndex
}
/*:
 ## BidirectionalCollection
 
 Supports backward and forward traversal.
 
 Inherits from `Collection`.
 */
struct MyBidirectionalCollection: BidirectionalCollection {
  // Collection
  var startIndex: Int { 0 }
  
  var endIndex: Int { 100 }
  
  func index(after i: Int) -> Int { i + 1 }
  
  subscript(position: Int) -> Int { position }
  
  // BidirectionalCollection
  func index(before i: Int) -> Int { i - 1 }
}

do {
  let collection = MyBidirectionalCollection()
  collection.last
  let reversedCollection: ReversedCollection = collection.reversed()
}
/*:
 - note:
 The `reversed()` method is always lazy when applied to a collection with
 bidirectional indices, but does not implicitly confer laziness on algorithms
 applied to its result.
 */
/*:
 ## RandomAccessCollection
 
 Supports efficient random-access index traversal.
 
 Inherits from `RandomAccessCollection`.
 */
struct MyRandomAccessCollection: RandomAccessCollection {
  // Collection
  var startIndex: Int { 0 }
  
  var endIndex: Int { 100 }
  
  func index(after i: Int) -> Int { i + 1 }
  
  subscript(position: Int) -> Int { position }
  
  // BidirectionalCollection
  func index(before i: Int) -> Int { i - 1 }
  
  // RandomAccessCollection
  // Either index is conform to the Strideable
  // or you must implement:
  func index(_ i: Int, offsetBy n: Int) -> Int { i + n }
  
  func distance(from start: Int, to end: Int) -> Int { end - start }
  
  // In this case index (Int) already complied to Strideable
}

do {
  let collection = MyRandomAccessCollection()
  let reversedCollection: ReversedCollection = collection.reversed()
}
/*:
 ## RangeReplaceableCollection
 
 Supports replacement of an arbitrary subrange of elements with the elements of
 another collection.
 
 Inherits from `Collection`.
 */
struct MyRangeReplaceableCollection: RangeReplaceableCollection {
  private var storage = [Int]()
  
  // Collection
  var startIndex: Int { storage.startIndex }
  
  var endIndex: Int { storage.endIndex }
  
  func index(after i: Int) -> Int { i + 1 }
  
  subscript(position: Int) -> Int { storage[position] }
  
  // RangeReplaceableCollection
  init() { }
  
  mutating func replaceSubrange<C: Collection<Int>>(_ subrange: Range<Int>,
                                                    with newElements: C) {
    self.storage.replaceSubrange(subrange, with: newElements)
  }
}

do {
  var collection = MyRangeReplaceableCollection()
  collection.reserveCapacity(15)

  collection.count
  collection.append(4)
  collection.append(contentsOf: [5, 6, 7, 8])
  collection.insert(contentsOf: [2, 3], at: 0)
  collection.insert(1, at: 0)
  Array(collection)

  collection.replaceSubrange(0...2, with: [0])

  collection.removeFirst()
  collection.remove(at: 0)
  collection.removeSubrange(0...2)
  collection.removeAll { $0 > 10 }
  collection.removeAll()
}
/*:
 - note:
 If the collection is also a `BidirectionalCollection` there is also a
 `removeLast()` method.
 */
/*:
 ## MutableCollection
 
 Supports subscript assignment.
 
 Inherits from `Collection`.
 */
struct MyMutableCollection: MutableCollection {
  private var storage = [1, 3, 6, 2]
  
  // Collection
  var startIndex: Int { 0 }
  
  var endIndex: Int { 100 }
  
  func index(after i: Int) -> Int { i + 1 }
  
  subscript(position: Int) -> Int {
    get { storage[position] }
    // MutableCollection
    set { storage[position] = newValue }
  }
}

do {
  var collection = MyMutableCollection()
  collection[0]
  collection[0] = 100
  collection[0]

  collection[0]
  collection[1]
  collection.swapAt(0, 1)
  collection[0]
  collection[1]
}
//: ## Slices
/*:
 - important:
 The accessed slice uses the same indices for the same elements as the original
 collection uses.
 */
do {
  let collection = Array(1...10)
  Array(collection[1...3])
  
  Array(collection.prefix(upTo: 2))
  Array(collection.prefix(through: 2))
  
  Array(collection.suffix(from: 5))
  Array(collection.suffix(2))
  
  collection[2..<4].sorted()
}
//: ## Standard library collections
/*: 
 ### Array
 
 An ordered, random-access collection.
 */
do {
  var _ = Array<Int>()
  var _ = [Int]()
  var _ = [Int](repeating: 10, count: 2)
  var _ = [1, 2]
}
/*:
 ### Set
 
 An unordered collection of unique elements.
 
 The elements mush be hashable.
 */
do {
  var _ = Set<Int>()
  var _: Set = [1, 2, 3]
}
/*: 
 ### Dictionary
 
 An **unordered** collection whose elements are key-value pairs.
 
 The key mush be hashable.
 */
do {
  var _ = Dictionary<Int, String>()
  var _ = [Int: String]()

  var dictionary = [1 : "apple", 2 : "banana"]
  dictionary[1] = nil
  dictionary[1]
  dictionary = [:]
  dictionary[1, default: "Hello"] // Default value

  // Creating a dictionary with a sequence
  Dictionary(uniqueKeysWithValues: [(1, "Name1"), (2, "Name2")])
  
  // Merging initializer and merge method
  Dictionary([("a", 1), ("b", 2), ("a", 3), ("b", 4)],
             uniquingKeysWith: { (first, _) in first })
  
  var dictionary1 = ["a": 1, "b": 2]
  dictionary1.merge(["a": 3, "c": 4]) { (current, _) in current }
  
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
  
  let dictionary2 = Dictionary(grouping: items) { $0.key }
  dictionary2[1]
  dictionary2[2]
  
  // Map Values
  ["a": 1, "b": 2].mapValues { String($0) }
  
  // Compact Map Values
  ["a": "1", "b": "Z"].compactMapValues(Int.init)
}
/*:
 ### KeyValuePairs
 
 An **ordered** collection whose elements are key-value pairs.
 
 Some operations that are efficient on a dictionary are slower when using
 `KeyValuePairs`.
 
 `KeyValuePairs` also allows duplicates keys.
 */
do {
  let keyValuePairs: KeyValuePairs = [1 : "a", 1 : "b"]
  keyValuePairs.first!.key
  keyValuePairs.first!.value
}
/*:
 When calling a function with a `KeyValuePairs parameter, you can pass a Swift
 dictionary literal without causing a Dictionary to be created.
 */
do {
  func foo(_ elements: KeyValuePairs<Int, String>) { }

  foo([1 : "a", 1 : "b"])
}
/*:
 ### ContiguousArray
 
 A `ContiguousArray` always stores its elements in a contiguous region of
 memory.
 
 Array stores its elements in a
 * contiguous region of memory - if its `Element` type is a value type,
 * NSArray - if its `Element` type is a class or `@objc` protocol.
 
 
 If your array's Element type is a class or `@objc` protocol and you do not need
 to bridge the array to `NSArray` or pass the array to Objective-C APIs, using
 `ContiguousArray` may be more efficient and have more predictable performance
 than `Array`.
 */
do {
  class Class { }
  let contiguousArray = ContiguousArray<Class>()
}
/*:
 ### CollectionDifference
 */
do {
  var old = [1, 2, 3, 0]
  let new = [0, 1, 2]
  var diff: CollectionDifference = new.difference(from: old).inferringMoves()
  let seq = Array(diff)
  seq[0]
  seq[1]
  seq[2]
  
  old.applying(diff) == new
  
  var array = old
  for c in diff {
    switch c {
      case .remove(offset: let o, element: _, associatedWith: _):
        array.remove(at: o)
      case .insert(offset: let o, element: let e, associatedWith: _):
        array.insert(e, at: o)
    }
  }
  array == new
}
//: ### Other
do {
  let allOne: Repeated = repeatElement(1, count: 5)
  let only10 = CollectionOfOne(10)
  let emptyCollection = EmptyCollection<Int>()
  let flatten = [0..<3, 8..<10, 15..<17].joined()
}
/*:
 ## Enumerate
 
 When enumerating a collection, the integer part of each pair is a counter for
 the enumeration, not necessarily the index of the paired value. These counters
 can only be used as indices in instances of zero-based, integer-indexed
 collections, such as `Array` and `ContiguousArray`.
 
 To iterate over the elements of a collection with its indices, use the
 `zip(_:_:)` function.
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
