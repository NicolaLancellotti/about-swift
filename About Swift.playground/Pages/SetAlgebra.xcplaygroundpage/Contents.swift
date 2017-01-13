//: [Previous](@previous)

/*:
 # SetAlgebra
 A type that provides mathematical set operations.
 */

/*:
 ## Set
 An unordered collection of unique elements.
 
 Implement SetAlgebra
*/
let set = Set(arrayLiteral: 1, 2, 3, 4)
let anotherSet: Set = [5, 10]
set.isEmpty

set.isDisjoint(with: anotherSet)
set.intersection(anotherSet)
set.isSubset(of: anotherSet)
set.isSubset(of: anotherSet)
set.union(anotherSet)

//: Set is complain to Collection
var setIter = set.makeIterator()
set.startIndex
/*:
 ## OptionSet
 A type that presents a mathematical set interface to a bit mask
 
 Inherits From SetAlgebra.
 */
struct MyFontStyle : OptionSet {
    let rawValue : Int // conforms to the BitwiseOperations protocol
    static let bold             = MyFontStyle(rawValue: 1 << 0)
    static let italic           = MyFontStyle(rawValue: 1 << 1)
    static let underline        = MyFontStyle(rawValue: 1 << 2)
    static let strikethrough    = MyFontStyle(rawValue: 1 << 3)
}

var style: MyFontStyle
style = []
style = .underline
style = [.bold, .italic]

style.formUnion([.bold, .italic])
style.insert(.strikethrough)
style.remove(.bold)
style.contains(.italic)


//: [Next](@next)
