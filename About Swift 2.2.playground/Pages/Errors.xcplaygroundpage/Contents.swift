//: [Previous](@previous)

/*:
 # Assertions
 If the condition evaluates to false, code execution ends, and your app is terminated.
 
 Assertions are disabled when your code is compiled with optimizations (target Release).
 */
assert(true, "message")

let vowel = "a"
switch vowel {
case "a":
    print("a")
case "e":
    print("e")
case "i":
    print("i")
case "o":
    print("o")
case "u":
    print("u")
default:
    assertionFailure()
}
/*:
 # Error Handling
 Errors are represented by values of types that conform to the ErrorType protocol.
 */
enum MyErrorType: ErrorType {
    case ErrorType1
    case ErrorType2(value: Int)
}
//:There are four ways to handle errors in Swift.

/*:
 1 - You can propagate the error from a function to the code that calls that function.
 
 Only throwing functions can propagate errors.
 */
func canThrowErrors(mustThrow: Bool = false) throws -> Int {
    if mustThrow {
        throw MyErrorType.ErrorType1
    } else {
        return 1
    }
}
/*:
 2 - Handle the error using a do-catch statement.
 
 If a catch clause doesn’t have a pattern, the clause matches any error and binds the error to a local
 constant named error.
 */
do {
    try canThrowErrors()
} catch MyErrorType.ErrorType1 {
    
} catch MyErrorType.ErrorType2(let value) where value > 3{
    
} catch {
    
}
//: 3 - Handle the error as an optional value.
let value1 = try? canThrowErrors()

// Equivalent to
let value2: Int?
do {
    value2 = try canThrowErrors()
} catch {
    value2 = nil
}
/*:
 4 - Assert that the error will not occur.
 
 If an error actually is thrown, you’ll get a runtime error.
 */
let value3 = try! canThrowErrors()
/*:
 ## Rethrowing Functions and Methods
 
 A function or method can be declared with the rethrows keyword to indicate that it throws an error only if one of its function parameters throws an error
 Rethrowing functions and methods must have at least one throwing function parameter.
 
 A throwing method can’t override a rethrowing method, and a throwing method can’t satisfy a protocol requirement for a rethrowing method. That said, a rethrowing method can override a throwing method, and a rethrowing method can satisfy a protocol requirement for a throwing method.
 */
func functionWithCallback(callback: () throws -> Int) rethrows {
    try callback()
}
/*:
 # Fatal Error
 */
//fatalError()
//: [Next](@next)
