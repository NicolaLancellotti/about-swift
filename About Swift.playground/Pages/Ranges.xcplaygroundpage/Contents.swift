//: [Previous](@previous)

//: # Ranges
let range: Range = 0.0..<5.0
range.contains(1)
range.clamped(to: 1.0..<10.0)
range.overlaps(1.0..<10.0)

let closedRange: ClosedRange = "a"..."ad"
closedRange.contains("ab")
//: Countable Ranges
let countableRange: CountableRange = 0..<5
let countableClosedRange: CountableClosedRange = 0...5

countableRange.forEach {_ in
    //...
}
//: [Next](@next)
