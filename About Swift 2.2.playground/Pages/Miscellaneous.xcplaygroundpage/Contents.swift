//: [Previous](@previous)

//: # Miscellaneous

//: ## Type Alias Declaration

typealias Length = Double
let length: Length = 0.0
//: ## Multiple separate statements on a single line
let cat = "?"; print(cat)
/*:
 ## Line Control Statement
 
 A line control statement is used to specify a line number and filename that can be different from the line number and filename of the source code being compiled. Use a line control statement to change the source code location used by Swift for diagnostic and debugging purposes.
 */
var file = #file
var line = #line

//#sourceLocation(file: "someFile", line: 1)
file = #file
line = #line
//#sourceLocation()
file = #file
line = #line
/*:
 ## @warn_unused_result
 
 Apply this attribute to a method or function declaration to have the compiler emit a warning when the method or function is called without using its result.
 */
struct Increaser {
    var value = 0
    
    //    @warn_unused_result(message:"my message")
    @warn_unused_result(mutable_variant:"increase")
    func increased() -> Int {
        return value + 1
    }
    
    mutating func increase() {
        value += 1
    }
}
/*:
 ## Lazy One-Time Initialization
 
 The lazy initializer for the global variables, global constants and stored type properties is run the first time that global is accessed, and is launched as dispatch_once to make sure that the initialization is atomic.
 */

/*:
 ## Increasing Performance by Reducing Dynamic Dispatch
 
 The final keyword is a restriction on a class, method, or property that indicates that the declaration cannot be overridden. This allows the compiler to safely elide dynamic dispatch indirection.
 
 Applying the private keyword to a declaration restricts the visibility of the declaration to the current file. This allows the compiler to find all potentially overriding declarations. The absence of any such overriding declarations enables the compiler to infer the final keyword automatically and remove indirect calls for methods and property accesses.
 
 Declarations with internal access (the default if nothing is declared) are only visible within the module where they are declared. Because Swift normally compiles the files that make up a module separately, the compiler cannot ascertain whether or not an internal declaration is overridden in a different file. However, if Whole Module Optimization is enabled, all of the module is compiled together at the same time. This allows the compiler to make inferences about the entire module together and infer final on declarations with internal if there are no visible overrides.
 */

/*:
 ## Optionals
 An optional is an enumeration with two associated Values:
 * case None
 * case Some(type)
 
 */
//let someOptional: Optional<Int> = 42
let someOptional: Int? = 42
let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
//: Enumeration Case Pattern
if case .some(let x)  = someOptional {
    //   print("x: \(x)")
}

for case .some(let number) in arrayOfOptionalInts {
    //    print("\(number)")
}
//: Optional Pattern
if case let x? = someOptional {
    //        print("x: \(x)")
}

for case let number? in arrayOfOptionalInts {
    //        print("\(number)")
}
//: [Next](@next)
