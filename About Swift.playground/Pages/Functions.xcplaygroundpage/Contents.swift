//: [Previous](@previous)
//: # Functions
//: ## Functions without parameters
func functionWithoutParameters() {
  
}

functionWithoutParameters()
//: ## Functions with return values
func functionWithReturnValue() -> Bool {
  return false
}

let boolValue1 = functionWithReturnValue()
/*:
 If the entire body of the function is a single expression, the function
 implicitly returns that expression.
 */
func functionWithImplicitReturnValue() -> Bool {
  false
}

let boolValue2 = functionWithImplicitReturnValue()
/*:
 ## Functions with parameters
 
 Each function parameter has both an argument label and a parameter name. The
 argument label is used when calling the function; each argument is written in
 the function call with its argument label before it. The parameter name is used
 in the implementation of the function. By default, parameters use their
 parameter name as their argument label.
 */
func difference(x: Int, y: Int) -> Int {
  x - y
}
difference(x: 1, y: 2)
//: ### Specifying argument labels
func difference(of x: Int, less y: Int) -> Int {
  x - y
}

difference(of: 1, less: 2)
/*:
 If you don’t want an argument label for a parameter, write an underscore (`_`)
 instead of an explicit argument label for that parameter.
 */
func difference(_ x: Int, _ y: Int) -> Int {
  x - y
}

difference(1, 2)
//: ## Functions with default parameter values
func functionWithDefaultParameterValue(value: Int = 12) -> Int {
  value
}

functionWithDefaultParameterValue()
functionWithDefaultParameterValue(value: 1)
/*:
 ## Functions with variadic parameters
 
 All parameters which follow variadic parameters must be labeled.
 */
func sum(_ numbers: Double...) -> Double {
  var sum = 0.0
  for value in numbers {
    sum += value
  }
  return sum
}

sum(1.0, 2.0, 3.0, 5)

func multipleVariadicParameters(a: Int..., b: Bool...) { }
multipleVariadicParameters(a: 1, 2, 3, b: false, true)
/*:
 ## Functions with in-out parameters
 
 * In-out parameters cannot have default values.
 * Variadic parameters cannot be marked as inout.
 
 If you pass a property that has observers to a function as an in-out parameter,
 the willSet and didSet observers are always called. This is because of the
 copy-in copy-out memory model for in-out parameters: The value is always
 written back to the property at the end of the function.
 */
func swapTwoInts(_ x: inout Int, _ y: inout Int) {
  (x, y) = (y, x)
}

var x = 1
var y = 2
swapTwoInts(&x, &y)
x
y
/*:
 ## Function overloading
 
 If a function with the same name but a distinct signature already exists, it
 just defines a new overload. Keep in mind that Swift allows function
 overloading even when two signatures differ only in their return type.
 */
func overloading(_ value: String) -> String {
  "String -> String"
}

func overloading(_ value: Int) -> String {
  "Int -> String"
}

func overloading() -> String {
  "Void -> String"
}
func overloading() -> Void {}

overloading("String")
overloading(1)
overloading() as String
/*:
 ## Early exit
 
 A guard statement is used to transfer program control out of a scope if one or
 more conditions aren’t met.
 */
func functionWithGuard(_ optionalValue: Int?) {
  guard let value = optionalValue else {
    print("error: value must not be nil")
    return
  }
  print("value: \(value)")
}
functionWithGuard(nil)
/*:
 ## Cleanup actions
 
 * The deferred statements lets you do any necessary cleanup that should be
 performed regardless of how execution leaves the current block of code whether
 it leaves because an error was thrown or because of a statement such as return
 or break.
 * The deferred statements may not contain any code that would transfer control
 out of the statements, such as a break or a return statement, or by throwing an
 error.
 * Deferred actions are executed in reverse order of how they are specified.
 */
func functionWithDefers() {
  defer {
    print("First defer")
  }
  defer {
    print("Second defer")
  }
  print("end")
}

functionWithDefers()
/*:
 ## Functions that never return
 
 Swift defines a `Never` type, which indicates that a function or method doesn’t
 return to its caller. Functions and methods with the Never return type are
 called nonreturning.
 
 Throwing and rethrowing functions can transfer program control to an
 appropriate catch block, even when they are nonreturning.
 */
func loop() -> Never  {
  while true {
    
  }
}
//: [Next](@next)
