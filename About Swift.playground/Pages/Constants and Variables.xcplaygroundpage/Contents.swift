//: [Previous](@previous)
//: # Constants and Variables
/*:
 ## Constants and variables keywords
 
 * `let` - constant,
 * `var` - variable.
 */
/*:
 ## Naming constants and variables
 
 Constant and variable names can contain almost any character, including Unicode
 characters.
 
 Constant and variable names cannot:
 * begin with a number,
 * contain whitespace characters,
 * contain mathematical symbols,
 * contain private-use (or invalid) Unicode code points.
 
 */
/*:
 ## Type annotations
 
 You can provide a type annotation when you declare a constant or variable, to
 be clear about the kind of values the constant or variable can store.
 */
var variable: String
variable = "Hello"
variable = "Ciao"

let constant: Int // Declaration
constant = 0      // Initialization
/*:
 ## Type inference
 Type inference enables a compiler to deduce the type of a particular expression
 automatically when it compiles your code, simply by examining the values you
 provide.
 */
let pi = 3.14159 // Double
let boolean = true  // Bool
let dictionary = [0: "0", 1: "1"] // [Int : String]
/*
 If you combine integer and floating-point literals in an expression, a type of
 Double will be inferred from the context.
 */
let anotherPi = 3 + 0.14159
/*:
 - experiment:
 Press the option key and click on a variable or constant name to see the type
 inferred.
 */
/*:
 ## Type placeholders
 */
let anotherDictionary: [Int: _] = [0: "0", 1: "1"] // [Int : String]
/*:
 ## Type safety
 
 Swift is a type-safe language, which means the language helps you to be clear
 about the types of values your code can work with.
 */
/*:
 * experiment:
 Try to uncomment the lines of code below.
 */
// let string: String = 1
// let cannotBeNegative: UInt = -1
// let tooBig: Int = Int.max + 1
/*:
 Floating-point values are always truncated when used to initialize a new
 integer value. This means that 4.75 becomes 4, and -3.9 becomes -3.
 */
let integerPi: Int = Int(pi)
//: ## Declare multiple constants/variables on a single line
let x = 0.0, y = 0.0, z = 0.0
var red: Int, green, blue: Double
/*:
 ## Observers for stored variables
 
 The variables you have encountered have all been stored variables.
 You have the option to define either or both of these observers on a variable:
 * `willSet` is called just before the value is stored,
 * `didSet` is called immediately after the new value is stored.
 
 If the body of the `didSet` observer refers to the old value, the getter is
 called before the observer, to make the old value available.
 */
var value = 10 {
  willSet {
    print("new: \(newValue) current: \(value)")
  }
  didSet{
    print("old: \(oldValue) current: \(value)")
  }
}

value = 100

var anInt = 10 {
  willSet(newInt) {
    print("new: \(newInt) current: \(anInt)")
  }
  didSet(oldInt) {
    print("old: \(oldInt) current: \(anInt)")
  }
}
/*:
 ## Computed variables
 
 They provide a getter and an optional setter to retrieve and set other
 properties and values indirectly.
 */
// Stored Variable
var km = 1.0

// Computed Variable
var miles: Double {
  set {
    km = newValue * 1.60934
  }
  get {
    // If the entire body of a getter is a single expression,
    // the getter implicitly returns that expression
    km * 0.621371
  }
  // The same as:
  // get {
  //   return km * 0.621371
  // }
}

miles = 4
km

km = 2
miles
//: ### Read-only computed variables.
var milesReadOnly: Double {
  km * 0.621371
}

milesReadOnly
//: [Next](@next)
