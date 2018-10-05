//: [Previous](@previous)

//: # Miscellaneous

//: ## Type Alias Declaration
typealias Length = Double
let length: Length = 0.0

typealias StringDictionary<T> = Dictionary<String, T>
// The following dictionaries have the same type.
var dictionary1: StringDictionary<Int> = [:]
var dictionary2: Dictionary<String, Int> = [:]

typealias Handler1 = (Int) -> Void
//:  You can provide parameter names for documentation purposes using the `_` in the argument label position.
typealias Handler2 = (_ token: Int) -> Void
//: ## Multiple separate statements on a single line
let cat = "?"; print(cat)
//: ## Introduce new scopes
do {
    //new scope
    do {
        //another scope
    }
}
/*:
 ## Compile-Time Diagnostic Statement
 ```
 #error("error message")
 #warning("warning message")
 ```
 */

/*:
 ## Literal Expression
 
 ### Line Control Statement
 
 A line control statement is used to specify a line number and filename that can be different from the line number and filename of the source code being compiled. Use a line control statement to change the source code location used by Swift for diagnostic and debugging purposes.
 */
var file = #file
var line = #line

//#sourceLocation(file: "someFile", line: 1)
file = #file
line = #line

//#sourceLocation() // Resets the source code location back to the default line numbering and filename
file = #file
line = #line

//: ### The column number in which it begins.
  #column
//: ### The name of the declaration in which it appears.
#function

func logFunctionName(string: String = #function) {
    print(string)
}
func myFunction() {
    logFunctionName() // Prints "myFunction()".
}

myFunction()
/*:
 ## Dynamic Member Lookup
 
 Apply this attribute to a class, structure, enumeration, or protocol to enable members to be looked up by name at runtime.
 
 In an explicit member expression, if there isn’t a corresponding declaration for the named member, the expression is understood as a call to the type’s subscript(dynamicMemberLookup:) subscript, passing a string literal that contains the member’s name as the argument. The subscript’s parameter type can be any type that conforms to the ExpressibleByStringLiteral protocol, and its return type can be any type.
 */
@dynamicMemberLookup
class DynamicDictionary {
    
    private var dictionary = [String: String]()
    
    subscript(dynamicMember member: String) -> String? {
        get {
            return dictionary[member]
        }
        set {
            dictionary[member] = newValue
        }
    }
}

let dic = DynamicDictionary()
dic.name
dic.name = "Nicola"
dic[dynamicMember: "name"]
/*:
 ## Discardable Result
 
 Apply this attribute to a function or method declaration to suppress the compiler warning when the function or method that returns a value is called without using its result.
 */
struct Increaser {
    var value = 0
    
    @discardableResult
    func increased() -> Int {
        return value + 1
    }
}


/*:
 ## Cross-module inlining and specialization
 Apply *inlinable* attribute to a function, method, computed property, subscript, convenience initializer, or deinitializer declaration to expose that declaration’s implementation as part of the module’s public interface. The compiler is allowed to replace calls to an inlinable symbol with a copy of the symbol’s implementation at the call site.
 
 Inlinable code can interact with public symbols declared in any module, and it can interact with internal symbols declared in the same module that are marked with the usableFromInline attribute.
 
 
 Apply *usableFromInline* attribute to a function, method, computed property, subscript, initializer, or deinitializer declaration to allow that symbol to be used in inlinable code that’s defined in the same module as the declaration. The declaration must have the internal access level modifier.
 
 Like the public access level modifier, *usableFromInline* attribute exposes the declaration as part of the module’s public interface. Unlike public, the compiler doesn’t allow declarations marked with *usableFromInline* to be referenced by name in code outside the module, even though the declaration’s symbol is exported.
 */
@inlinable
public func foo() {
    bar()
}

@usableFromInline
internal func bar() {
    
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
 * case none
 * case some(Wrapped)
 
 */
//let someOptional: Optional<Int> = 42
let someOptional: Int? = 42
let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
//: Enumeration Case Pattern
if case .some(let x)  = someOptional {
    x
}

for case .some(let number) in arrayOfOptionalInts {
    number
}
//: Optional Pattern
if case let x? = someOptional {
    x
}

for case let number? in arrayOfOptionalInts {
    number
}
//: [Next](@next)

