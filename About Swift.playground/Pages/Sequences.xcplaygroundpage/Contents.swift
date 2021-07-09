//: [Previous](@previous)
/*: 
 # Sequences
 
 A sequence is a list of values that you can step through one at a time.
 */
//: ## Example
struct FibonacciIterator: IteratorProtocol {
  private var previus = 0.0
  private var current = 1.0
  private var flag = false
  
  mutating func next() -> Double? {
    guard flag else {
      flag = true
      return 1
    }
    
    let value = current + previus
    previus = current
    current = value
    return value
  }
}

struct Fibonacci: Sequence {
  func makeIterator() -> FibonacciIterator {
    FibonacciIterator()
  }
}

var fibonacci = Fibonacci()
var fibonacciIter = fibonacci.makeIterator()
fibonacciIter.next()
fibonacciIter.next()
fibonacciIter.next()

fibonacciIter = fibonacci.makeIterator()
fibonacciIter.next()
fibonacciIter.next()
fibonacciIter.next()
//: ### Conform to both Sequence and IteratorProtocol
struct Countdown: Sequence, IteratorProtocol {
  var count: Int
  
  mutating func next() -> Int? {
    if count == 0 {
      return nil
    } else {
      defer { count -= 1 }
      return count
    }
  }
}

var countdown = Countdown(count: 10)
countdown.next()
countdown.next()
//: ## Standard Library Functions for Make Sequences
/*:
 ### sequence(first:next:)
 
 Returns a sequence formed from first and repeated lazy applications of next.
 */
class Node {
  var parent: Node?
  let name: String
  
  init(name: String, parent: Node?) {
    self.name = name
    self.parent = parent
  }
}

let root = Node(name: "root", parent: nil)
let child = Node(name: "child", parent: root)

// Walk the elements of a tree from a node up to the root
let unfoldSequence1: UnfoldSequence = sequence(first: child, next: { $0.parent })
/*:
 ### sequence(state:next:)
 
 Returns a sequence formed from repeated lazy applications of next to a mutable state.
 */
let unfoldSequence2: UnfoldSequence = sequence(state: 10) { (value: inout Int) -> String? in
  value -= 1
  return value == 0 ? nil : "Value: \(value)"
}
/*:
 ### stride(from:to:by:)
 
 Returns (self, self + stride, self + 2 * stride, … last) where last < end.
 */
let start = 1.0, end = 2.0, offset = 0.5
let strideTo: StrideTo = stride(from: start, to: end, by: offset)
/*:
 ### stride(from:through:by:)
 
 Returns  (self, self + stride, self + 2 * stride, … last) where last <= end.
 */
let strideThrough: StrideThrough = stride(from: start, through: end, by: offset)
/*:
 ### zip
 
 Creates a sequence of pairs built out of two underyling sequences.
 
 If the two sequences passed to zip(_:_:) are different lengths, the resulting sequence is the same length as the shorter sequence.
 */
let words = ["one", "two", "three", "four"]
let naturalNumbers = 1...Int.max

let zipped: Zip2Sequence = zip(words, naturalNumbers)
for (word, number) in zipped {
  print("\(word): \(number)")
}
//: ## Methods
//: ### Iterate
let threeTwoOne = Countdown(count: 3)
for count in threeTwoOne {
  print(count)
}

var iterator = threeTwoOne.makeIterator()
while let count = iterator.next() {
  print(count)
}

iterator = threeTwoOne.makeIterator()
for count in IteratorSequence(iterator) {
  print(count)
}
//: ### Enumerate
let enumeratedSequence: EnumeratedSequence = threeTwoOne.enumerated()

for (n, elem) in threeTwoOne.enumerated() {
  print(n, elem)
}
/*:
 ### Flat
 A sequence that presents the elements of a base sequence of sequences concatenated.
 */
let s = stride(from: 1, to: 2, by: 1)
let flat: FlattenSequence = [s, s].joined()
Array(flat)
/*: 
 ### Join
 
 A sequence that presents the elements of a base sequence of sequences concatenated using a given separator.
 */
let joined: JoinedSequence = [1...2, 4...5].joined(separator: [0])
Array(joined)
//: ### Split
let aSequence2 = [0, 1, 0, 0, 2, 0, 0, 3, 0, 0, 4, 0, 0, 5]
var split = aSequence2.split(maxSplits: 4, omittingEmptySubsequences: true) { $0 == 0 }
split
//: ### Subsequences
var aSequence = stride(from: 0, through: 5, by: 1)
Array(aSequence)

Array(aSequence.prefix(2))
Array(aSequence.prefix(while: {$0 < 3}))

Array(aSequence.suffix(2))
Array(aSequence.drop(while: {$0 < 3}))

Array(aSequence.dropFirst(2))
Array(aSequence.dropLast(2))

aSequence.first { $0 > 2 }!
//: ### Sort
aSequence.sorted()
aSequence.sorted { $0 > $1 }
aSequence.reversed()
//: ### Queries
aSequence.contains(10)
aSequence.starts(with: [1, 2])
aSequence.elementsEqual(1...10)

aSequence.lexicographicallyPrecedes([0, 3, 4])
aSequence.lexicographicallyPrecedes([2, 4, 6]) { $0 * 2 == $1 }

aSequence.min()
aSequence.max()

let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
let greatestHue = hues.max { $0.value < $1.value }

aSequence.allSatisfy { $0 > 0 }
/*:
 ## LazySequenceProtocol
 
 Lazy sequences can be used to avoid needless storage allocation and computation, because they use an underlying sequence for storage and compute their elements on demand.
 
 */
let intFibonacci: LazyMapSequence = Fibonacci().lazy.map(Int.init)
var lazyMapIter:  LazyMapSequence<Fibonacci, Int>.Iterator = intFibonacci.makeIterator()
lazyMapIter.next()
lazyMapIter.next()
lazyMapIter.next()
lazyMapIter.next()

let evenIntFibonacci: LazyFilterSequence = Fibonacci().lazy.filter { Int($0) % 2 == 0}
var lazyFilterIter: LazyFilterSequence<Fibonacci>.Iterator = evenIntFibonacci.makeIterator()
lazyFilterIter.next()
lazyFilterIter.next()
lazyFilterIter.next()
lazyFilterIter.next()
//: ### Add New Lazy Sequence Operation
struct LazyEvenIterator<Base: IteratorProtocol>: IteratorProtocol where Base.Element == Int{
  var iterator: Base
  
  mutating func next() -> Int? {
    guard let value = iterator.next() else {
      return nil
    }
    return value % 2 == 0 ? value : iterator.next()
  }
}

struct LazyEvenSequence<Base: Sequence>: LazySequenceProtocol where Base.Iterator.Element == Int{
  var sequence: Base
  
  func makeIterator() -> LazyEvenIterator<Base.Iterator> {
    LazyEvenIterator(iterator: sequence.makeIterator())
  }
}

extension LazySequenceProtocol where Iterator.Element == Int{
  /// **Complexity:** O(1)
  func even() -> LazyEvenSequence<Self> {
    LazyEvenSequence(sequence: self)
  }
}

var lazyEvenIter = stride(from: 1, through: 100, by: 1).lazy.even().makeIterator()
lazyEvenIter.next()
lazyEvenIter.next()
lazyEvenIter.next()
//: [Next](@next)
