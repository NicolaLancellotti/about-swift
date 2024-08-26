//: [Previous](@previous)
/*:
 # Assertions
 
 If the condition evaluates to false, code execution ends, and your app is
 terminated.
 */
/*:
 - important:
 Assertions are checked only in debug builds.
 */
assert(true)

if false {
  assertionFailure()
}
/*:
 # Preconditions
 
 Use this function to detect conditions that must prevent the program from
 proceeding.
 
 If the condition evaluates to false, code execution ends, and your app is
 terminated.
 */
/*:
 - important:
 Preconditions are checked in both debug and production builds.
 */
precondition(true)
if false {
  preconditionFailure()
}
/*:
 # Error Handling
 
 Errors are represented by values of types that conform to the `ErrorProtocol`.
 */
enum MyErrorType: Error {
  case error1
  case error2(value: Int)
  case error3
}
/*:
 ### Propagate the error from a function to the code that calls that function
 
 Only throwing functions can propagate errors.
 */
func canThrowErrors(_ mustThrow: Bool = false) throws -> Int {
  if mustThrow {
    throw MyErrorType.error1
  }
  return 0
}
/*:
 ### Handle the error using a do-catch statement
 
 If a catch clause doesn’t have a pattern, the clause matches any error and
 binds the error to a local
 constant named error.
 */
do {
  try canThrowErrors()
} catch MyErrorType.error1, MyErrorType.error3 {
  
} catch MyErrorType.error2(let value) where value > 3{
  
} catch {
  
}
//: ### Handle the error as an optional value
let value1 = try? canThrowErrors()

// Equivalent to
let value2: Int?
do {
  value2 = try canThrowErrors()
} catch {
  value2 = nil
}
/*:
 ### Assert that the error will not occur
 
 If an error actually is thrown, you’ll get a runtime error.
 */
let value3 = try! canThrowErrors()
/*:
 ## Rethrowing functions and methods
 
 A function or method can be declared with the `rethrows` keyword to indicate
 that it throws an error only if one of its function parameters throws an error
 Rethrowing functions and methods must have at least one throwing function
 parameter.
 
 A throwing method can’t override a rethrowing method, and a throwing method
 can’t satisfy a protocol requirement for a rethrowing method. That said, a
 rethrowing method can override a throwing method, and a rethrowing method can
 satisfy a protocol requirement for a throwing method.
 */
func functionWithCallback(_ callback: () throws -> Int) rethrows {
  try callback()
}
/*:
 # Fatal Error
 */
if false {
  fatalError()
}
/*:
 # Result
 
 A value that represents either a success or a failure, including an associated
 value in each case.
 */
enum DivisionError: Error {
  case divisionByZero
}

func safeDivision(_ x: Double, _ y: Double) -> Result<Double, DivisionError> {
  switch y != 0 {
  case true: .success(x / y)
  case false: .failure(.divisionByZero)
  }
}

let quotient  = safeDivision(1, 0)
switch quotient {
  case .success(let value): value
  case .failure(let error): error
}
let mappedError = quotient.mapError { _ in MyErrorType.error1}
let stringValue = quotient.map{String($0)}
//: ### Create a new result by evaluating a throwing closure
let value = Result {
  try canThrowErrors(false)
}
switch value {
  case .success(let value): value
  case .failure(let error): error
}
//: [Next](@next)
