/*:
 # Constants and Variables
 */

/*:
 ## Constants and Variables Keywords
 * let - constant.
 * var - variable.
 */

/*:
 ## Naming Constants and Variables
 Constant and variable names can contain almost any character, including Unicode characters.
 
 Constant and variable names cannot:
 * begin with a number.
 * contain whitespace characters.
 * contain mathematical symbols.
 * contain private-use (or invalid) Unicode code points.
 
 */

/*:
 ## Type Annotations
 
 You can provide a type annotation when you declare a constant or variable, to be clear about the kind of values the constant or variable can store.
 */
var variableString: String
variableString = "Hello"
variableString = "Ciao"
variableString = "Privet"

let constantInt: Int // Declaration
constantInt = 0      // Initialization
/*:
 ## Type Inference
 Type inference enables a compiler to deduce the type of a particular expression automatically when it compiles your code, simply by examining the values you provide.
 */
let pi = 3.14159        // Double
let booleanValue = true // Bool
//: If you combine integer and floating-point literals in an expression, a type of Double will be inferred from the context.
let anotherPi = 3 + 0.14159
/*:
 - experiment:
 Press the option key and click on a variable or constant name to see the type inferred.
 */

/*:
 ## Type Safety
 
 Swift is a type-safe language, which means the language helps you to be clear about the types of values your code can work with.
 */
/*:
 * experiment:
 Try to uncomment the lines of code below.
 */
//let aString: String = 1
//let cannotBeNegative: UInt = -1
//let tooBig: Int = Int.max + 1

//: Floating-point values are always truncated when used to initialize a new integer value. This means that 4.75 becomes 4, and -3.9 becomes -3.
let integerPi: Int = Int(pi)
//: ## Declare Multiple Constants/Variables on a Single Line
let x = 0.0, y = 0.0, z = 0.0
var red:Int, green, blue: Double
/*:
 ## Observers for Stored Variables
 The variables you have encountered have all been stored variables.
 
 You have the option to define either or both of these observers on a variable:
 * willSet is called just before the value is stored.
 * didSet is called immediately after the new value is stored.
 
 */
var value = 10 {
    willSet {
        print("new: \(newValue) actual: \(value)")
    }
    didSet{
        print("old: \(oldValue) actual: \(value)")
    }
}

value = 100

var anInt = 10 {
    willSet(newInt) {
        print("new: \(newInt) actual: \(anInt)")
    }
    didSet(oldInt) {
        print("old: \(oldInt) actual: \(anInt)")
    }
}
/*:
 ## Computed Variables
 They provide a getter and an optional setter to retrieve and set other properties and values indirectly.
 */
// Stored Variable
var km = 1.0

// Computed Variable
var miles: Double {
    get {
        return km * 0.621371
    }
    set {
        km = newValue * 1.60934
    }
}

miles = 4
km

km = 2
miles
//: ### Read-only Computed Variables.
var miles2: Double {
    return km * 0.621371
}

miles2
//: [Next](@next)
