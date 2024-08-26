//: [Previous](@previous)
//: # Convertible Protocols
struct Structure {
  let value: Int
}
let instance = Structure(value: 10)
/*:
 ## CustomStringConvertible
 
 Accessing a type's description property directly or using
 `CustomStringConvertible` as a generic constraint is discouraged.
 */
extension Structure: CustomStringConvertible {
  var description: String { "my description" }
}

print(instance)
String(describing: instance)
/*:
 ## CustomDebugStringConvertible
 
 Accessing a type's debugDescription property directly or using
 `CustomDebugStringConvertible` as a generic constraint is discouraged.
 */
extension Structure: CustomDebugStringConvertible {
  var debugDescription: String { "my debug description" }
}

debugPrint(instance)
String(reflecting: instance)
/*:
 ## LosslessStringConvertible
 
 A type that can be represented as a string in a lossless, unambiguous way.
 
 Inherits from `CustomStringConvertible`.
 */
extension Structure: LosslessStringConvertible {
  init?(_ description: String) {
    guard let value = Int(description) else { return nil }
    self.value = value
  }
}

Structure("10")?.value
//: [Next](@next)
