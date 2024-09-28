//: [Previous](@previous)
/*:
 # Ownership
 */
/*:
 ## Copyable structs and enums
 Every struct and enum has a default conformance to `Copyable`.
 */
struct ExplicitCopyableStruct: Copyable {}
struct ImplicitCopyableStruct {}
/*:
 ## Noncopyable structs and enums
 The conformance to `Copyable` is suppressed with `~Copyable`.
 */
struct NoncopyableStruct: ~Copyable {
  
  // A noncopyable struct or enum may declare a deinit
  deinit { }
  
  // Ownership of the self parameter
  consuming func consumingSelf() {
    discard self // ends the lifetime of self without running its deinit
  }
  
  borrowing func borrowingSelf() {}
  
  mutating func  mutatingSelf() {}
}
//: ## Parameter ownership modifiers
func funcWithParameterOwnershipModifier(_: borrowing NoncopyableStruct) { }
func funcWithParameterOwnershipModifier(_: consuming NoncopyableStruct) { }
func funcWithParameterOwnershipModifier(_: inout NoncopyableStruct) {}
//: ## Operators
func operators() {
  do {
    let value = NoncopyableStruct()
    let value1 = value // consuming
  }
  
  do {
    let value = NoncopyableStruct()
    _ = value // borrowing
  }
  
  do {
    let value = NoncopyableStruct()
    consume value
    // let value1 = value // error
  }
  
  do {
    let value = ""
    let value1 = copy value // explicit copy
  }
}
/*:
 ## Partial consumption
 - Noncopyable aggregates without deinits can be consumed field-by-field, if
 they are defined in the current module or frozen.
 - Noncopyable aggregates with a deinit can be consumed field-by-field within
 that deinit.
 */
/*:
 ## Suppression of Copyable
 */
// Protocols
protocol ProtocolThatSuppressesCopyable: ~Copyable {}

// Protocol extensions
extension ProtocolThatSuppressesCopyable {
  func onlyCopyable() {}
}
extension ProtocolThatSuppressesCopyable where Self: ~Copyable {
  func evenNoncopyable() {}
}

// Protocol inheritance
protocol P1: ProtocolThatSuppressesCopyable /*, Copyable */ {}
protocol P2: ProtocolThatSuppressesCopyable, ~Copyable {}

// Conformance to protocols
extension ImplicitCopyableStruct: ProtocolThatSuppressesCopyable {}
extension NoncopyableStruct: ProtocolThatSuppressesCopyable {}

do {
  // Protocol extensions methods
  ImplicitCopyableStruct().onlyCopyable()
  // NoncopyableStruct().onlyCopyable() // Error
  ImplicitCopyableStruct().evenNoncopyable()
  NoncopyableStruct().evenNoncopyable()
  
  // Generics
  func onlyCopyable<T: ProtocolThatSuppressesCopyable>(_ value: T) {}
  func evenNoncopyable<T: ProtocolThatSuppressesCopyable & ~Copyable>(_ value: borrowing T) {}
  onlyCopyable(ImplicitCopyableStruct())
  // onlyCopyable(NoncopyableStruct()) // Error
  evenNoncopyable(ImplicitCopyableStruct())
  evenNoncopyable(NoncopyableStruct())
  
  // Existential types
  var _: any ~Copyable = ImplicitCopyableStruct()
  var _: any ~Copyable = NoncopyableStruct()
  
  // Any == any Copyable
  var _: Any = ImplicitCopyableStruct()
  // var _: Any = NoncopyableStruct() // Error
  
  var _: any ProtocolThatSuppressesCopyable & ~Copyable = NoncopyableStruct()
  // var _: any ProtocolThatSuppressesCopyable = NoncopyableStruct() // Error
}
//: [Next](@next)
