//: [Previous](@previous)
/*:
 # Opaque Types
 
 An opaque type hides its value’s type information.
 
 Opaque return types cannot be used in the requirements of a protocol and for a non-final declaration within a class.
 
 An opaque type refers to one specific type, although the caller of the function isn’t able to see which type.
 
 If a function with an opaque return type returns from multiple places, all of the possible return values must have the same type.
 */
protocol MyProtocol: Equatable { }

protocol AnotherProtocol { }

struct MyType<T: Equatable>: MyProtocol, AnotherProtocol {
  var value: T
}
//: ### Return type of a function
func makeOpaque<T: Equatable>(value: T) -> some MyProtocol & AnotherProtocol {
  MyType(value: value)
}
//: ### Type of a variable
do {
  let opaqueValue: some MyProtocol & AnotherProtocol = makeOpaque(value: 10)
  opaqueValue is MyType<Int> // Check at runtime
}
//: ### Return type of a method, type of a variable and return type of a subscript
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
//: [Next](@next)
