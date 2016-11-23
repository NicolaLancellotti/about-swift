//: [Previous](@previous)

/*: 
 # Sequence
 A sequence is a list of values that you can step through one at a time.
 */
struct Countdown {
    let start: Int
}
/*:
 ## IteratorProtocol
 
 A type that supplies the values of a sequence one at a time.
 */
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
/*:
 ## Sequence
 A type that provides sequential, iterated access to its elements.
 */
extension Countdown: Sequence {
    func makeIterator() -> CountdownIterator {
        return CountdownIterator(self)
    }
}

let threeTwoOne = Countdown(start: 3)
for count in threeTwoOne {
//    print(count)
}
//: Internally Swift rewrites
var __g = threeTwoOne.makeIterator()
while let count = __g.next() {
//    print(count)
}

//: Some Methods
var aSequence = Array(0...5)
aSequence.underestimatedCount
aSequence.prefix(2)
aSequence.dropFirst(2)
aSequence.dropLast(2)
aSequence.suffix(2)

aSequence.first {
    $0 > 2
}

aSequence = [0, 1, 0, 0, 2, 0, 0, 3, 0, 0, 4, 0, 0, 5]
aSequence.split(maxSplits: 2, whereSeparator: {
    $0 == 0
})
aSequence.split(maxSplits: 4, omittingEmptySubsequences: false, whereSeparator: {
    $0 == 0
})

aSequence.contains(10)
aSequence.elementsEqual(1...10)


let sequenze123 = [1, 2, 3]

sequenze123.lexicographicallyPrecedes([0, 3, 4])
sequenze123.lexicographicallyPrecedes([2, 4, 6]) {
    $0 * 2 == $1
}

sequenze123.max()
let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
let greatestHue = hues.max {
    $0.value < $1.value
}

sequenze123.min()
sequenze123.reversed()
sequenze123.sorted()
sequenze123.sorted {
    $0 > $1
}

sequenze123.starts(with: [1, 2])


for (n, c) in aSequence.enumerated() {
    print("\(n): '\(c)'")
}


let joined = [1...2, 4...5].joined(separator: [3])
Array(joined)
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
//: ## Functions

/*:
 ### Zip
 
 Creates a sequence of pairs built out of two underyling sequences.
 
 If the two sequences passed to zip(_:_:) are different lengths, the resulting sequence is the same length as the shorter sequence.
 */
let words = ["one", "two", "three", "four"]
let naturalNumbers = 1...Int.max

let zipped = zip(words, naturalNumbers)
for (word, number) in zipped {
//    print("\(word): \(number)")
}

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
for node in sequence(first: child, next: { $0.parent }) {
//    print(node.name)
}

/*:
 ### sequence(state:next:)
 
 Returns a sequence formed from repeated lazy applications of next to a mutable state.
 */
let seq0 = sequence(state: 10) { (value: inout Int) -> String? in
    value -= 1
    return value == 0 ? nil : "Value: \(value)"
}

for value in seq0 {
    print(value, terminator: " ")
}
print("")
/*:
 ### stride(from:to:by:)
 
 Returns (self, self + stride, self + 2 * stride, … last) where last < end.
 */
let start = 1.0, end = 2.0, offset = 0.5

let seq1 = stride(from: start, to: end, by: offset)
for value in seq1  {
    print(value, terminator: " ")
}
print("")
/*:
 ### stride(from:through:by:)
 
 Returns  (self, self + stride, self + 2 * stride, … last) where last <= end.
 */
let seq2 = stride(from: start, through: end, by: offset)
for value in seq2 {
    print(value, terminator: " ")
}
/*:
 ## LazySequenceProtocol
 
 Lazy sequences can be used to avoid needless storage allocation and computation, because they use an underlying sequence for storage and compute their elements on demand.
 
 */
let lazySequence = [1, 2, 3].lazy.map { $0 * 2 }
//: [Next](@next)
