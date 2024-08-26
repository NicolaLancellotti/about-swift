//: [Previous](@previous)
//: # Able Protocols
struct Structure {
  var value: Int = 0
}
let instance = Structure()
/*:
 ## Equatable
 
 A type that can be compared for value equality.
 
 When adopting Equatable, only the `==` operator is required to be implemented.
 The standard library provides an implementation for `!=`.
 */
extension Structure: Equatable {
  static func ==(lhs: Structure, rhs: Structure) -> Bool {
    lhs.value == rhs.value
  }
}
/*:
 Swift provides synthesized implementations of the equivalence operators for the
 following kinds of custom types:
 * structures that have only stored properties that conform to the Equatable
 protocol,
 * enumerations that have only associated types that conform to the Equatable
 protocol,
 * enumerations that have no associated types.
 
 Declare Equatable conformance as part of the type’s original declaration to
 receive these default implementations.
 */
struct Point: Equatable {
  let x: Int
  let y: Int
}

Point(x: 0, y: 1) == Point(x: 0, y: 1)
Point(x: 0, y: 1) != Point(x: 0, y: 1)
/*:
 ## Hashable
 
 A type that provides an integer hash value.
 
 Inherits from `Equatable`.
 */
extension Structure: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
}

Structure().hashValue

var hasher = Hasher()
hasher.combine(0)
hasher.finalize()
/*:
 ## Comparable
 
 A type that can be compared using the relational operators `<`, `<=`, `>=`,
 and `>`.
 
 Inherits from `Equatable`.
 
 A type conforming to Comparable need only supply the `<` and `==` operators;
 default implementations of `<=`, `>`, `>=`, and `!=` are supplied by the
 standard library.
 */
extension Structure: Comparable {
  static func <(lhs: Structure, rhs: Structure) -> Bool {
    lhs.value < rhs.value
  }
}

Structure(value: 1) < Structure(value: 2)
Structure(value: 1) <= Structure(value: 2)
Structure(value: 1) > Structure(value: 2)
Structure(value: 1) >= Structure(value: 2)
//: ### Synthesized implementations of comparable for enumerations
enum ComparableEnumeration: Comparable {
  case first
  case second(Int)
}

ComparableEnumeration.first < ComparableEnumeration.second(1)
ComparableEnumeration.second(1) < ComparableEnumeration.second(2)
//: ### Function with comparable parameters
max(1, 2, 3)
min(1, 2, 3)
/*:
 ## Strideable
 
 Conforming types are notionally continuous, one-dimensional values that can be
 offset and measured.
 
 Inherits from `Comparable`.
 */
extension Structure: Strideable {
  func advanced(by n: Int) -> Structure {
    Structure(value: self.value + n)
  }
  
  func distance(to other: Structure) -> Int {
    self.value - other.value
  }
}

let instance1 = Structure(value: 1)
let instance2 = instance1.advanced(by: 1)
instance2.value
instance1.distance(to: instance2)
/*:
 ## RawRepresentable
 
 A type that can be converted to and from an associated raw value.
 */
struct Structure1: RawRepresentable {
  var value: Int = 0
  
  init?(rawValue: String) {
    guard let value = Int(rawValue) else {
      return nil
    }
    self.value = value
  }
  
  var rawValue: String {
    String(value)
  }
}

Structure1(rawValue: "123")?.rawValue
//: ## Identifiable
extension Structure: Identifiable {
  var id: Int { value }
}

instance.id

class Class: Identifiable { }
Class().id
//: [Next](@next)
