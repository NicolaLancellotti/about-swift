//: [Previous](@previous)
/*:
 # Optional Chaining
 
 Optional chaining is a process for querying and calling properties, methods,
 and subscripts on an optional that might currently be nil.
 
 The result of an optional chaining call is of the same type as the expected
 return value, but wrapped in an optional.
 
 You specify optional chaining by placing a question mark (`?`) after the
 optional value on which you wish to call a property, method or subscript if the
 optional is non-nil.
 */
class Class {
  var property = ""
  
  subscript(i: Int) -> Bool { i.isMultiple(of: 2) }
  
  func methodWithIntResult() -> Int { 42 }
  
  func methodWithVoidResult() {}
}

var instance: Class?
instance = Class()
/*:
 ## Accessing properties and subscripts through optional chaining
 Any attempt to set a property through optional chaining returns a value of type
 Void?
 */
instance?.property = "value"
instance?.property

instance?[0]
/*:
 ## Calling methods through optional chaining
 
 Functions and methods with no return type have an implicit return type of Void.
 */
instance?.methodWithIntResult()
instance?.methodWithVoidResult()
/*:
 ## Linking multiple levels of chaining
 
 You can link together multiple levels of optional chaining to drill down to
 properties, methods, and subscripts deeper within a model. However, multiple
 levels of optional chaining do not add more levels of optionality to the
 returned value.
 
 * If the type you are trying to retrieve is not optional, it will become
 optional because of the optional chaining.
 * If the type you are trying to retrieve is already optional, it will not
 become more optional because of the chaining.
 */
//: [Next](@next)
