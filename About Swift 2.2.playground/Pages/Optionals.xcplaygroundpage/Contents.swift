//: [Previous](@previous)

/*:
 # Optionals
 You use optionals in situations where a value may be absent.
 
 An optional says:
 * There is a value, and it equals x.
 * There isn’t a value at all.
 */
var possibleString: String?
possibleString = "Ciao"
possibleString = nil
possibleString = "Hello"


/*:
 ## Forced Unwrapping
 
 Once you’re sure that the optional does contain a value, you can access its underlying value by adding an exclamation mark (!) to the end of the optional’s name.
 
 Trying to use ! to access a non-existent optional value triggers a runtime error.
 */

if possibleString != nil {
    print(possibleString!)
}

/*:
 ## Optional Binding
 
 You use optional binding to find out whether an optional contains a value, and if so, to make that value available as a temporary constant.
 */

if let constantString = possibleString {
    constantString
}

var possibleName: String? = "Nicola"
var possibleAge: Int? = 23

if let name = possibleName, let age = possibleAge {
    print("Name: \(name)")
    print("Age: \(age)")
}

possibleName = nil
if let name = possibleName, let age = possibleAge {
    print("Name: \(name)")
    print("Age: \(age)")
} else {
    print("nil")
}

if let name = possibleName, let age = possibleAge where age > 23 {
    print("Name: \(name)")
    print("Age: \(age)")
} else {
    print("Age isn't > 22")
}

/*:
 ## Implicitly Unwrapped Optionals
 
 Sometimes it is clear from a program’s structure that an optional will always have a value, after that value is first set. In these cases, it is useful to remove the need to check and unwrap the optional’s value every time it is accessed, because it can be safely assumed to have a value all of the time.
 
 These kinds of optionals are defined as implicitly unwrapped optionals. You write an implicitly unwrapped optional by placing an exclamation mark (String!) rather than a question mark (String?) after the type that you want to make optional.
 
 If an implicitly unwrapped optional is nil and you try to access its wrapped value, you’ll trigger a runtime error.
 */
let possibleString1: String? = "An optional string."
let forcedString: String = possibleString1! // requires an exclamation mark

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark

if assumedString != nil {
    print(assumedString)
}

if let definiteString = assumedString {
    print(definiteString)
}

/*:
 ## Nil Coalescing Operator
 
 `let c = a ?? b`\
 is the same of \
 `let c = a != nil ? a! : b`
 
 */

let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil

var colorNameToUse = userDefinedColorName ?? defaultColorName

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName


//: [Next](@next)
