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
//: ## Functions With Parameters

//: * Objective-C Method Style
func printDifferenceOf(x: Int, less y: Int) {
    print("\(x - y)")
}
printDifferenceOf(1, less: 2)

//: * C Function Style

func printDifference(x: Int, _ y: Int) {
    print("\(x - y)")
}
printDifference(1, 2)

//: * Other
func printDifference(minuend x: Int, subtrahend y: Int) {
    print("\(x - y)")
}
printDifference(minuend: 10, subtrahend: 6)


func printAnotherDifferenceOf(x: Int, less: Int) {
    print("\(x - less)")
}
printAnotherDifferenceOf(10, less: 6)

//: ## Functions With Default Parameter Values
func funcWithDefaultParameterValue(param: Int = 12) {
    
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
swap(&a, &b)

/*:
 ## Function overloading
 
 If a function with the same name but a distinct signature already exists, it just defines a new overload. Keep in mind that Swift allows function overloading even when two signatures differ only in their return type.
 */
func foo(aString: String) {
    print(aString)
}

func foo() {
    print("Foo!")
}

func foo() -> String {
    return "Foo!"
}

foo("Hello, world!")
foo() as Void
var value: String = foo()

//: ## Nested Functions
func globalFunction() {
    var value = 1
    func nestedFunction() {
        print(value)
    }
}
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
var value: Int? = nil
doSomething(value)


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
