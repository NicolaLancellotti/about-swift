//: [Previous](@previous)

//: # Sequence
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
 ### stride(from:through:by:)
 
 Returns (self, self + stride, self + 2 * stride, … last) where last < end.
 */
let start = 1.0, end = 2.0, offset = 0.5

let seq1 = stride(from: start, to: end, by: offset)
for value in seq1  {
    print(value, terminator: " ")
}
print("")
/*:
 ### stride(from:to:by:)
 
 Returns  (self, self + stride, self + 2 * stride, … last) where last <= end.
 */
let seq2 = stride(from: start, through: end, by: offset)
for value in seq2 {
    print(value, terminator: " ")
}
//: [Next](@next)
