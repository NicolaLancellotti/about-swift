//: [Previous](@previous)

/*:
 # SetAlgebra
 A type that provides mathematical set operations.
 */

/*:
 ## Set
 An unordered collection of unique ***hashable*** elements.
 
 Complain to SetAlgebra and Collection
*/

let set: Set = [1, 2, 3]
let anotherSet: Set = [1, 2, 3, 4, 5]

//: ### Fundamental Set Operations
set.intersection(anotherSet)
set.symmetricDifference(anotherSet)
set.union(anotherSet)
set.subtracting(anotherSet)
//: ### Set Membership and Equality
set.isSubset(of: anotherSet)
set.isSuperset(of: anotherSet)
set.isDisjoint(with: anotherSet)
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
