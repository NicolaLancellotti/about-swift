//: [Previous](@previous)
import Foundation
//: # Functions

//: ## Functions Without Parameters
func functionWithoutParameters() {
    
}

functionWithoutParameters()
//: ## Functions With Return Values
func funcWithReturnValue() -> Bool {
    return false
}

let aBool = funcWithReturnValue()
/*:
 ## Functions With Parameters
 Function parameters have both an external parameter name and a local parameter name. An external parameter name is used to label arguments passed to a function call. A local parameter name is used in the implementation of the function.
 
 By default, the first parameter omits its external name, and the second and subsequent parameters use their local name as their external name
 */
func functionWithParameters(localParameterName1: Int,
                            externalParameterName2 localParameterName2: Int,
                                                   localParameterName3: Int,
                                                 _ localParameterName4: Int) {
    let sum = localParameterName1 + localParameterName2 + localParameterName3 + localParameterName4
    print("Sum: \(sum)")
}

functionWithParameters(1, externalParameterName2: 2, localParameterName3: 3, 4)


func printDifference(of x: Int, less y: Int) {
    print("\(x - y)")
}

printDifference(of: 1, less: 2)


func sum(x: Int, _ y: Int) -> Int {
    return x + y
}

sum(1, 2)
//: ## Functions With Default Parameter Values
func funcWithDefaultParameterValue(param: Int = 12) {
    print("Value: \(param)")
}

funcWithDefaultParameterValue()
funcWithDefaultParameterValue(1)
/*:
 ## Functions With Variadic Parameters
 
 A function may have at most one variadic parameter.
 */
func sum(numbers: Double...) -> Double {
    var sum = 0.0
    for value in numbers {
        sum += value
    }
    return sum
}

sum(1.0, 2.0, 3.0, 5)

max(1, 2, 3, 4, 5, 6)
/*:
 ## Functions With In-Out Parameters
 
 * In-out parameters cannot have default values.
 * Variadic parameters cannot be marked as inout.
 
 If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called. This is because of the copy-in copy-out memory model for in-out parameters: The value is always written back to the property at the end of the function.
 */
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var a = 1
var b = 2

swapTwoInts(&a, &b)

a
b
/*:
 ## Function overloading
 
 If a function with the same name but a distinct signature already exists, it just defines a new overload. Keep in mind that Swift allows function overloading even when two signatures differ only in their return type.
 */
func foo(value: String) {
    print(value)
}

func foo(value: Int) {
    print(value)
}

func foo() {
    print("Foo!")
}

func foo() -> String {
    return "Foo!"
}

foo("Hello, world!")
foo(1)
foo() as Void
var value: String = foo()
//: ## Nested Functions
func globalFunction() {
    var variable = 1
    
    func nestedFunction() {
        // Nested functions can capture values from their enclosing function.
        variable = 2
        print("Variable: \(variable)")
    }
    
    nestedFunction()
}

globalFunction()
/*:
 ## Early Exit
 A guard statement is used to transfer program control out of a scope if one or more conditions aren’t met.
 */
func doSomething(optionalValue: Int?) {
    guard let value = optionalValue else {
        print("*** Error **** value must not be nil")
        return
    }
    print("value: \(value)")
}

var optionalValue: Int? = nil
doSomething(optionalValue)
/*:
 ## Cleanup Actions
 
 * This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves the current block of code—whether it leaves because an error was thrown or because of a statement such as return or break.
 
 * The deferred statements may not contain any code that would transfer control out of the statements, such as a break or a return statement, or by throwing an error.
 
 * Deferred actions are executed in reverse order of how they are specified.
 
 */
func functionWithDefers() {
    defer {
        print("First defer")
    }
    defer {
        print("Second defer")
    }
}

functionWithDefers()
/*:
 ## Noreturn Functions
 
 You can mark a function or method type with @noreturn attribute to indicate that the function or method doesn’t return to its caller.
 */
@noreturn func loop() {
    while true {
        
    }
}

@noreturn func terminateApp() {
    abort()
}
//: [Next](@next)
