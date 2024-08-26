//: [Previous](@previous)
//: # Miscellaneous
//: ## Type alias declaration
typealias Length = Double
let length: Length = 0.0

typealias StringDictionary<T> = Dictionary<String, T>
// The following dictionaries have the same type.
var dictionary1: StringDictionary<Int> = [:]
var dictionary2: [String: Int] = [:]

typealias Handler1 = (Int) -> Void
/*:
 You can provide parameter names for documentation purposes using the `_` in the
 argument label position.
 */
typealias Handler2 = (_ token: Int) -> Void
//: ## Multiple separate statements on a single line
let cat = "?"; print(cat)
//: ## Introduce new scopes
do {
  // new scope
  do {
    // another scope
  }
}
/*:
 ## Conditional compilation block
 
 Swift code can be conditionally compiled based on the evaluation of build
 configurations.
 Build configurations include:
 * the literal true and false values,
 * command line flags,
 * the platform-testing functions:
    * `os()` -  valid arguments: macOS, iOS, watchOS, tvOS,
    * `arch()` - valid arguments: x86_64, arm, arm64, i386,
    * `swift() ` - valid arguments: >= or < followed by a version number,
    * `compiler()` - valid arguments: >= or < followed by a version number,
    * `canImport()` - valid arguments: a module name,
    * `targetEnvironment()` - valid arguments: simulator, macCatalyst.
 
 The `arch(arm)` build configuration does not return true for ARM 64 devices.
 The `arch(i386)` build configuration returns true when code is compiled for the
 32–bit iOS simulator.
 */
#if os(macOS)
// do something
#elseif arch(arm)
// do something
#elseif swift(>=2.1)
// do something
#elseif !FLAG
// do something
#else
// do something
#endif
//: ### Features detection
#if hasFeature(ConciseMagicFile)

#endif
//: ### Conditional compilation for attributes
#if hasAttribute(preconcurrency)
@preconcurrency
#endif
protocol P: Sendable {
  func f()
}
//: ### Surround postfix member expressions
let value = [1, 2, 3]
#if true
  .count
#else
  .first
#endif

value

/*:
 ## Compile-time diagnostic statement
 
 ```
 #error("error message")
 #warning("warning message")
 ```
 */
/*:
 ## Literal expression
 
 ### Line control statement
 
 A line control statement is used to specify a line number and filename that can
 be different from the line number and filename of the source code being
 compiled. Use a line control statement to change the source code location used
 by Swift for diagnostic and debugging purposes.
 */
#sourceLocation(file: "someFile", line: 1)

// Resets the source code location back to the default line numbering and filename
#sourceLocation()
//: ### The path to the file in which it appears
#filePath
//: ### The name of the file and module in which it appears
#fileID
#file // upcoming feature
//: ### The column number in which it begins
#column
//: ### The name of the declaration in which it appears
#function

func logFunctionName(string: String = #function) {
  print(string)
}
func function() {
  logFunctionName() // Prints "myFunction()"
}
function()
/*:
 ## Lazy one-time initialization
 
 The lazy initializer for the global variables, global constants and stored type
 properties is run the first time that global is accessed, and is launched as
 `dispatch_once` to make sure that the initialization is atomic.
 */
/*:
 ## Increasing performance by reducing dynamic dispatch
 
 The final keyword is a restriction on a class, method, or property that
 indicates that the declaration cannot be overridden. This allows the compiler
 to safely elide dynamic dispatch indirection.
 
 Applying the private keyword to a declaration restricts the visibility of the
 declaration to the current file. This allows the compiler to find all
 potentially overriding declarations. The absence of any such overriding
 declarations enables the compiler to infer the final keyword automatically and
 remove indirect calls for methods and property accesses.
 
 Declarations with internal access (the default if nothing is declared) are only
 visible within the module where they are declared. Because Swift normally
 compiles the files that make up a module separately, the compiler cannot
 ascertain whether or not an internal declaration is overridden in a different
 file. However, if Whole Module Optimization is enabled, all of the module is
 compiled together at the same time. This allows the compiler to make inferences
 about the entire module together and infer final on declarations with internal
 if there are no visible overrides.
 */
//: [Next](@next)
