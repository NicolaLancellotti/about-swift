//: [Previous](@previous)

/*:
 # Assertions
 If the condition evaluates to false, code execution ends, and your app is terminated.
 */

/*:
 - important:
 Assertions are checked only in debug builds
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
 # Preconditions
 
 Use this function to detect conditions that must prevent the program from proceeding.
 
 If the condition evaluates to false, code execution ends, and your app is terminated.
 */

/*:
 - important:
 Preconditions are checked in both debug and production builds
 */
precondition(1 == 1)
//preconditionFailure("some message")
/*:
 # Error Handling
 Errors are represented by values of types that conform to the ErrorProtocol.
 */
enum MyErrorType: Error {
  case errorType1
  case errorType2(value: Int)
  case errorType3
}
//: There are four ways to handle errors in Swift.

/*:
 1 - You can propagate the error from a function to the code that calls that function.
 
 Only throwing functions can propagate errors.
 */
func canThrowErrors(_ mustThrow: Bool = false) throws -> String {
  if mustThrow {
    throw MyErrorType.errorType1
  } else {
    return "no error"
  }
}
/*:
 2 - Handle the error using a do-catch statement.
 
 If a catch clause doesn’t have a pattern, the clause matches any error and binds the error to a local
 constant named error.
 */
do {
  try canThrowErrors()
} catch MyErrorType.errorType1, MyErrorType.errorType3 {
  
} catch MyErrorType.errorType2(let value) where value > 3{
  
} catch {
  
}
//: 3 - Handle the error as an optional value.
let value1 = try? canThrowErrors()

// Equivalent to
let value2: String?
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
func functionWithCallback(_ callback: () throws -> Int) rethrows {
  try callback()
}
/*:
 # Fatal Error
 */
//fatalError()
/*:
 # Result
 
 A value that represents either a success or a failure, including an associated value in each case
 */
enum DivisionError: Error {
  case divisionByZero
}

func safeDivision(_ x: Double, _ y: Double) -> Result<Double, DivisionError> {
  if y != 0 {
    return .success(x / y)
  } else {
    return .failure(.divisionByZero)
  }
}

let result1 = safeDivision(1, 0)
switch result1 {
  case .success(let value): value
  case .failure(let error): error
}
let mappedError = result1.mapError { _ in MyErrorType.errorType1}
mappedError

let result2 = safeDivision(10, 2)
switch result2 {
  case .success(let value): value
  case .failure(let error): error
}
let stringValue = result2.map{String($0)}
stringValue


let result3 = Result {
  try canThrowErrors(false)
}
switch result3 {
  case .success(let value): value
  case .failure(let error): error
}
//: [Next](@next)
