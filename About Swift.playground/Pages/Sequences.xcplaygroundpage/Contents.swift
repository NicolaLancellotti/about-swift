//: [Previous](@previous)

/*: 
 # Sequences
 A sequence is a list of values that you can step through one at a time.
 */

//: ## Example
struct Countdown {
    let start: Int
}

struct CountdownIterator: IteratorProtocol {
    let countdown: Countdown
    var times = 0
    
    init(_ countdown: Countdown) {
        self.countdown = countdown
    }
    
    mutating func next() -> Int? {
        let nextNumber = countdown.start - times
        guard nextNumber > 0 else { return nil }
        times += 1
        return nextNumber
    }
}
extension Countdown: Sequence {
    func makeIterator() -> CountdownIterator {
        return CountdownIterator(self)
    }
}
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
    //    print("\(word): \(number)")
}
//: ## Methods
//: ### Iterate
let threeTwoOne = Countdown(start: 3)
for count in threeTwoOne {
//    print(count)
}

var iterator = threeTwoOne.makeIterator()
while let count = iterator.next() {
//    print(count)
}

iterator = threeTwoOne.makeIterator()
for count in IteratorSequence(iterator) {
//    print(count)
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
let flat: FlattenSequence = [1...2, 4...5].joined()
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
Array(aSequence.dropFirst(2))
Array(aSequence.dropLast(2))
Array(aSequence.suffix(2))
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
/*:
 ## LazySequenceProtocol
 
 Lazy sequences can be used to avoid needless storage allocation and computation, because they use an underlying sequence for storage and compute their elements on demand.
 
 */
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
        return FibonacciIterator()
    }
}

let intFibonacci: LazyMapSequence = Fibonacci().lazy.map(Int.init)
var it1: LazyMapIterator = intFibonacci.makeIterator()
it1.next()
it1.next()
it1.next()
it1.next()

let evenIntFibonacci: LazyFilterSequence = intFibonacci.lazy.filter { $0 % 2 == 0}
var it2: LazyFilterIterator = evenIntFibonacci.makeIterator()
it2.next()
it2.next()
it2.next()
it2.next()
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
        return LazyEvenIterator(iterator: sequence.makeIterator())
    }
    
}

extension LazySequenceProtocol where Iterator.Element == Int{
    
    /// **Complexity:** O(1)
    func even() -> LazyEvenSequence<Self> {
        return LazyEvenSequence(sequence: self)
    }
}


var it3 = stride(from: 1, through: 100, by: 1).lazy.even().makeIterator()
it3.next()
it3.next()
it3.next()
//: [Next](@next)
