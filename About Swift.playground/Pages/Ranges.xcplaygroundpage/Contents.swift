//: [Previous](@previous)
//: # Ranges
/*:
 - note:
 All ranges implement RangeExpression protocol.
 */
//: ## Countable Ranges
let countableRange: CountableRange = 0..<5
countableRange.count

let countableClosedRange: CountableClosedRange = 0...5
countableClosedRange.count

let countablePartialRangeFrom: CountablePartialRangeFrom = 5...
var iterator = countablePartialRangeFrom.makeIterator()
iterator.next()
iterator.next()
//: ## Uncountable Ranges
let range: Range = 0.0..<5.0
range.contains(1)

let closedRange: ClosedRange = "a"..."ad"
closedRange.contains("ab")

let partialRangeFrom: PartialRangeFrom = 5.0...
partialRangeFrom.contains(5)

let partialRangeThrough: PartialRangeThrough = ...5.0
partialRangeThrough.contains(5)

let partialRangeUpTo: PartialRangeUpTo = ..<5.0
partialRangeUpTo.contains(5)
//: [Next](@next)
