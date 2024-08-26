//: [Previous](@previous)
/*:
 # Optionals
 You use optionals in situations where a value may be absent.
 
 An optional says:
 * there is a value, and it equals x,
 * there isn’t a value at all.
 */
var string: String?
string = "Ciao"
string = nil
string = "Hello"
/*:
 ## Forced unwrapping
 
 Once you’re sure that the optional does contain a value, you can access its
 underlying value by adding an exclamation mark `!` to the end of the optional’s
 string.
 
 Trying to use `!` to access a non-existent optional value triggers a runtime
 error.
 */
if string != nil {
  print(string!)
}
/*:
 ## Optional binding
 
 You use optional binding to find out whether an optional contains a value, and
 if so, to make that value available as a temporary constant.
 */
if let string = string {
  print("Value: \(string)")
}

if case let string? = string { // Optional Pattern syntax
  print("Value: \(string)")
}

var integer: Int? = 23
/*
 You can include as many optional bindings and Boolean conditions in a singleif
 statement as you need to, separated by commas.
 */
if let string = string, let integer = integer {
  print("string: \(string), integer: \(integer)")
} else {
  print("`string` is nil or `integer` is nil")
}

if let string = string, let integer = integer , integer > 10 {
  print("string: \(string) integer: \(integer)")
} else {
  print("`string` is nil or `integer` is nil or `integer` is not > 10")
}
//: ### if let shorthand
if let string, let integer {
  print("string: \(string) integer: \(integer)")
}
/*:
 ## Implicitly unwrapped optionals
 
 Sometimes it is clear from a program’s structure that an optional will always
 have a value, after that value is first set. In these cases, it is useful to
 remove the need to check and unwrap the optional’s value every time it is
 accessed, because it can be safely assumed to have a value all of the time.
 
 These kinds of optionals are defined as implicitly unwrapped optionals. You
 write an implicitly unwrapped optional by placing an exclamation mark
 (`String!`) rather than a question mark (`String?`) after the type that you
 want to make optional.
 
 If an implicitly unwrapped optional is nil and you try to access its wrapped
 value, you’ll trigger a runtime error.
 */
let optionalString: String? = "value"
optionalString! // it requires an exclamation mark

let implicitlyUnwrappedString: String! = "value"
implicitlyUnwrappedString // no need for an exclamation mark

if implicitlyUnwrappedString != nil {
  implicitlyUnwrappedString
}

if let string = implicitlyUnwrappedString {
  string
}
/*:
 ## Nil coalescing operator
 
 `a ?? b`\
 is the same of \
 `if a != nil { a! } else { b }`
 */
let defaultColor = "red"

var optionalColor: String?   // defaults to nil
var color = optionalColor ?? defaultColor

optionalColor = "green"
optionalColor = optionalColor ?? defaultColor
//: [Next](@next)
