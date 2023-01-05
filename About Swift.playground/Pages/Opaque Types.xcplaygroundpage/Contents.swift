//: [Previous](@previous)
/*:
 # Opaque Types
 */
/*:
 ## Opaque Result Types
 An opaque type hides its value’s type information.
 Opaque result types cannot be used in the requirements of a protocol and for a non-final declaration within a class.
 
 An opaque type refers to one specific type, although the caller of the function isn’t able to see which type.
 
 If a function with an opaque result type returns from multiple places, all of the possible return values must have the same type.
 */
protocol MyProtocol: Equatable { }

protocol AnotherProtocol<A> {
  associatedtype A
}

struct MyType<T: Equatable>: MyProtocol, AnotherProtocol {
  typealias A = Bool
  var value: T
}
//: ### Result type of a function
func makeOpaque<T: Equatable>(value: T) -> some MyProtocol & AnotherProtocol<Bool> {
  MyType(value: value)
}
//: ### Type of a variable
do {
  let opaqueValue: some MyProtocol & AnotherProtocol<Bool> = makeOpaque(value: 10)
  opaqueValue is MyType<Int> // Check at runtime
}
//: ### Result type of a method, type of a variable and result type of a subscript
struct MyCollection1 {
  var storage = [MyType<Int>]()
  
  init(values: Int...) {
    storage = values.map(MyType.init)
  }
  
  var first: some MyProtocol {
    get { storage[0] }
    // set { storage[0] = newValue }
  }
  
  subscript(index: Int) -> some MyProtocol {
    get { return storage[index] }
    // set (newValue) { storage[index] = newValue }
  }
  
  func random() -> some MyProtocol {
    storage.randomElement()!
  }
}

do {
  let collection = MyCollection1(values: 1, 2)
  collection.random()
  
  let firstWithSubscript: some MyProtocol = collection[0]
  let firstWithProperty: some MyProtocol = collection.first
  
  firstWithSubscript == firstWithSubscript
  firstWithProperty == firstWithProperty
  
  // Error
  // firstWithProperty == firstWithSubscript
}
/*: ### Structural opaque result types
 Opaque result types are allowed in structural positions in the result type of a function, the type of a variable, or the result type of a subscript.
 
 If the result type of a function, the type of a variable, or the result type of a subscript is a function type, that function type can only contain structural opaque types in return position.
 */
func makeOptionalOpaque<T: Equatable>(value: T, flag: Bool) -> (some MyProtocol & AnotherProtocol)? {
  if flag {
    return MyType(value: value)
  } else {
    return Optional<MyType<T>>.none
  }
}
makeOptionalOpaque(value: 10, flag: true)
makeOptionalOpaque(value: 10, flag: false)
/*:
 ## Differences with returning a Protocol Type
 
 - Protocols loses type identity
 - Returned type cannot have any associated types
 - Returned type cannot have requirements that involve Self
 - Disables optimizations
 */
//: ### Opaque types compose well with the generics system
func genericFunction<T: AnotherProtocol>(value: T) -> some Collection {
  Array<T>(arrayLiteral: value)
}

do {
  let opaqueValue: some AnotherProtocol = MyType(value: 10)
  let collection: some Collection = genericFunction(value: opaqueValue)
  print(collection)
}

do {
  // Error
  // let value: AnotherProtocol = MyType(value: 10)
  // let collection = genericFunction(value: value)
}
//: ### Opaque types preserves type identity
let opaqueValue10 = makeOpaque(value: 10)
let opaqueValue11 = makeOpaque(value: 11)
let opaqueValueString = makeOpaque(value: "0")

opaqueValue10 == opaqueValue11
// Error
// opaqueValue10 == opaqueValueString
//: ### Returned opaque type can have associated types and can have requirements that involve Self
protocol MyCollection2Protocol: Equatable {
  associatedtype Element: Equatable
  
  var first: Element {get set}
  
  subscript(index: Int) -> Element {get set}
  
  func copy() -> Self
}

struct MyCollection2: MyCollection2Protocol, Equatable {
  var storage = [MyType<Int>]()
  
  init(values: Int...) {
    storage = values.map(MyType.init)
  }
  
  var first: MyType<Int> {
    get { storage[0] }
    set { storage[0] = newValue }
  }
  
  subscript(index: Int) -> MyType<Int> {
    get { storage[index] }
    set (newValue) { storage[index] = newValue }
  }
  
  func copy() -> MyCollection2 {
    var instance = MyCollection2()
    instance.storage = self.storage
    return instance
  }
  
}

do {
  let collection: some MyCollection2Protocol = MyCollection2(values: 1, 2)
  collection.copy() == collection
  
  let firstWithSubscript = collection[0]
  let firstWithProperty = collection.first
  firstWithSubscript == firstWithSubscript
  firstWithProperty == firstWithProperty
  
  // No more an error
  firstWithProperty == firstWithSubscript
}
//: ### Special case
protocol AProtocol {
  associatedtype Element: SignedInteger
  
  var value: Element {get}
  // var otherValue: Element {get }
}

struct AType: AProtocol {
  
  var value: some SignedInteger = 1
  // var otherValue: some SignedInteger = 1
}

AType().value == AType().value
/*:
 ## Opaque Parameter Declarations
 Opaque parameter types can only be used in parameters of a function, initializer, or subscript declaration.
 
 The caller determines the type of the opaque type via type inference.
 */
func f1(x: some Collection, y: some Collection) { }
//: is equivalent to
func f2<T: Collection, U: Collection>(x: T, y: U) { }

f1(x: [1, 2], y: [1 : "1", 2 : "2"])
f2(x: [1, 2], y: [1 : "1", 2 : "2"])
//: [Next](@next)
