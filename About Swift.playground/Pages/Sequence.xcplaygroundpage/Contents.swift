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
    print(count)
}
//: Internally Swift rewrites
var __g = threeTwoOne.makeIterator()
while let count = __g.next() {
    print(count)
}
//: [Next](@next)
