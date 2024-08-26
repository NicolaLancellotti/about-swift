//: [Previous](@previous)
/*:
 # Opaque Types
 */
/*:
 ## Opaque result types
 An opaque type hides its value’s type information.
 Opaque result types cannot be used in the requirements of a protocol and for a
 non-final declaration within a class.

 ### Result type of a function
 
 An opaque type refers to one specific type, although the caller of the function
 isn’t able to see which type.
 
 If a function with an opaque result type returns from multiple places,
 all of the possible return values must have the same type.
 
 The same-type restriction for functions with `if #available` conditions is
 relaxed: if an `if #available` condition is always executed, it can return a
 different type than the type returned by the rest of the function.
 */

protocol ElementProtocol: Equatable {
  associatedtype T
  var element: T? { get }
}

struct StructureWithOptional<T: Equatable>: ElementProtocol {
  var value: T?
  var element: T? { value }
}

@available(macOS 15, *)
struct StructureWithArray<T: Equatable>: ElementProtocol {
  var value: [T]
  var element: T? { return value.first }
}

func makeOpaque<T: Equatable>(value: T?) -> some ElementProtocol {
  if #available(macOS 15, *) {
    return StructureWithArray(value: value.map{[$0]} ?? [])
  }
  
  if let value {
    return StructureWithOptional(value: value)
  } else {
    return StructureWithOptional<T>(value: nil)
  }
}

let opaqueValue: some ElementProtocol = makeOpaque(value: 10)
opaqueValue is StructureWithOptional<Int> // Check at runtime
/*: ### Structural opaque result types
 Opaque result types are allowed in structural positions in the result type of a
 function, the type of a variable, or the result type of a subscript.
 
 If the result type of a function, the type of a variable, or the result type of
 a subscript is a function type, that function type can only contain structural
 opaque types in return position.
 */
func makeOptionalOpaque(value: Int?) -> (some ElementProtocol)? {
  if let value {
    return StructureWithOptional(value: value)
  } else {
    return Optional<StructureWithOptional<Int>>.none
  }
}
makeOptionalOpaque(value: 10)?.element
makeOptionalOpaque(value: nil)
//: ### Opaque types compose well with the generics system
func genericFunction<T: ElementProtocol>(value: T) -> some Collection {
  Array<T>(arrayLiteral: value)
}
  
let collection: some Collection = genericFunction(value: opaqueValue)
//: ### Opaque types preserves type identity
let opaqueValue10 = makeOpaque(value: 10)
let opaqueValue11 = makeOpaque(value: 11)
opaqueValue10 == opaqueValue11

let opaqueValueString = makeOpaque(value: "abc")
//opaqueValue10 == opaqueValueString // Error
/*:
 ## Opaque parameter declarations
 Opaque parameter types can only be used in parameters of a function,
 initializer, or subscript declaration.
 
 The caller determines the type of the opaque type via type inference.
 */
func f1(x: some Collection, y: some Collection) { }
//: is equivalent to
func f2<T: Collection, U: Collection>(x: T, y: U) { }

f1(x: [1, 2], y: [1 : "1", 2 : "2"])
f2(x: [1, 2], y: [1 : "1", 2 : "2"])
//: [Next](@next)
