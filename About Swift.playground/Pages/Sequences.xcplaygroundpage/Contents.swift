//: [Previous](@previous)
/*: 
 # Sequences
 
 A sequence is a list of values that you can step through one at a time.
 */
struct FibonacciIterator: IteratorProtocol {
  private var previous = 0.0
  private var current = 1.0
  private var count = 0
  
  mutating func next() -> Double? {
    if count < 2 {
      defer { count += 1 }
      return Double(count)
    }
    let value = current + previous
    (previous, current) = (current, value)
    return value
  }
}

struct Fibonacci: Sequence {
  func makeIterator() -> FibonacciIterator {
    FibonacciIterator()
  }
}

do {
  var fibonacci = Fibonacci()
  var iterator = fibonacci.makeIterator()
  iterator.next()
  iterator.next()
  iterator.next()
  iterator.next()
  iterator.next()
  iterator.next()
  iterator.next()
}
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

do {
  var countdown = Countdown(count: 2)
  countdown.next()
  countdown.next()
  countdown.next()
}
//: ## Functions
/*:
 ### sequence(first:next:)
 */
class Node {
  var parent: Node?
  let name: String
  
  init(name: String, parent: Node?) {
    self.name = name
    self.parent = parent
  }
}

do {
  let root = Node(name: "root", parent: nil)
  let child = Node(name: "child", parent: root)
  
  var fromNodeToRoot = sequence(first: child, next: { $0.parent })
  fromNodeToRoot.next()?.name
  fromNodeToRoot.next()?.name
}
/*:
 ### sequence(state:next:)
 */
do {
  var countdown = sequence(state: 2) { (value: inout Int) -> String? in
    if value > 0 {
      defer { value -= 1}
      return "Value: \(value)"
    }
    return nil
  }
  countdown.next()
  countdown.next()
  countdown.next()
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
 
 If the two sequences passed to `zip(_:_:)` are different lengths, the resulting
 sequence is the same length as the shorter sequence.
 */
do {
  let words = ["one", "two", "three", "four"]
  let numbers = 1...Int.max
  let zipped: Zip2Sequence = zip(words, numbers)
  var iterator = zipped.makeIterator()
  iterator.next()
  iterator.next()
}
//: ## Methods
//: ### makeIterator
let threeTwoOne = Countdown(count: 3)
for value in threeTwoOne {
  print(value)
}

var iterator = threeTwoOne.makeIterator()
while let value = iterator.next() {
  print(value)
}

iterator = threeTwoOne.makeIterator()
for value in IteratorSequence(iterator) {
  print(value)
}
//: ### enumerated
do {
  var iterator = ["a", "b"].enumerated().makeIterator()
  iterator.next()
  iterator.next()
}
/*:
 ### joined
 */
do {
  let seq: FlattenSequence = [1...2, 4...5].joined()
  Array(seq)
}
do {
  let seq: JoinedSequence = [1...2, 4...5].joined(separator: [3])
  Array(seq)
}
//: ### split
do {
  let seq = [0, 1, 2, 0, 0, 3, 4, 0, 5, 0, 6]
  var split = seq.split(maxSplits: 2, omittingEmptySubsequences: true) { $0 == 0 }
  Array(split[0])
  Array(split[1])
  Array(split[2])
}
//: ### Subsequences
var seq = 0...10

Array(seq.prefix(2))
Array(seq.prefix(while: {$0 < 3}))

Array(seq.suffix(2))
Array(seq.drop(while: {$0 < 3}))

Array(seq.dropFirst(2))
Array(seq.dropLast(2))

seq.first { $0 > 2 }!
//: ### Sort
seq.sorted()
seq.sorted { $0 > $1 }
Array(seq.reversed())
//: ### Queries
seq.contains(10)
seq.starts(with: [0, 1])
seq.elementsEqual(0...10)

seq.lexicographicallyPrecedes([0, 3, 4])
seq.lexicographicallyPrecedes([2, 4, 6]) { $0 < $1 }

seq.min()
seq.max()

seq.allSatisfy { $0 > 1 }
/*:
 ## LazySequenceProtocol
 
 Lazy sequences can be used to avoid needless storage allocation and
 computation, because they use an underlying sequence for storage and compute
 their elements on demand.
 
 */
do {
  var iterator = Fibonacci().lazy.map(Int.init).makeIterator()
  iterator.next()
  iterator.next()
  iterator.next()
  iterator.next()
}
//: ### Add new lazy sequence operation
struct LazyEvenIterator<Base: IteratorProtocol>: IteratorProtocol where Base.Element == Int{
  var iterator: Base
  
  mutating func next() -> Int? {
    guard let value = iterator.next() else { return nil }
    return value.isMultiple(of: 2) ? value : iterator.next()
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

do {
  var iterator = (1...1000).lazy.even().makeIterator()
  iterator.next()
  iterator.next()
  iterator.next()
}
//: [Next](@next)
