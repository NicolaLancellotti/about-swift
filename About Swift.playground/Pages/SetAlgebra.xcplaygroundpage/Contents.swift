//: [Previous](@previous)
/*:
 # SetAlgebra
 
 A type that provides mathematical set1 operations.
 */
/*:
 ## Set
 
 An unordered collection of unique `hashable` elements.
 
 Conforms to `SetAlgebra` and `Collection`.
 */
let set1: Set = [1, 2, 3]
let set2: Set = [1, 2, 3, 4, 5]
//: ### Fundamental set1 operations
set1.intersection(set2)
set1.symmetricDifference(set2)
set1.union(set2)
set1.subtracting(set2)
//: ### Set membership and equality
set1.isSubset(of: set2)
set1.isSuperset(of: set2)
set1.isDisjoint(with: set2)
/*:
 ## OptionSet
 
 A type that presents a mathematical set1 interface to a bit mask.
 
 Inherits from `SetAlgebra`.
 */
struct MyFontStyle : OptionSet {
  let rawValue : Int
  static let bold             = MyFontStyle(rawValue: 1 << 0)
  static let italic           = MyFontStyle(rawValue: 1 << 1)
  static let underline        = MyFontStyle(rawValue: 1 << 2)
  static let strikethrough    = MyFontStyle(rawValue: 1 << 3)
}

var style: MyFontStyle = []
style = .underline
style = [.bold, .italic]

style.formUnion([.bold, .italic])
style.insert(.strikethrough)
style.remove(.bold)
style.contains(.italic)
//: [Next](@next)
