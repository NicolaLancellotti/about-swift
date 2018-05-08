//: [Previous](@previous)

//: # Control Flow
let condition1 = false
let condition2 = false
let condition3 = false
//: ## For-In

//: 0 <= i <= 4
for i in 0...4  {
    // do something
}
//: 0 <= i < 4
for _ in 0..<4 {
    // do something
}
/*:
 * callout(Wildcard Pattern):
 A wildcard pattern matches and ignores any value and consists of an underscore (_). Use a wildcard pattern when you don’t care about the values being matched against.
 */

//: i = 0, 2, 4
for i in 0...4 where i % 2 == 0  {
    // do something
}
//: is the same of:
for i in 0...4 {
    if i % 2 == 0 {
        // do something
    }
}

//: ## While
while condition1 {
    // do something
}
//: ## Repeat-While
repeat {
    // do something
} while condition1

//: ## If
if condition1 {
   // do something
} else if condition2 {
    // do something
} else {
    // do something
}
/*:
 ## Switch
 * Every switch statement must be exhaustive. (If it’s not appropriate to provide a case for every possible value, you can define a default case to cover any values that are not addressed explicitly).
 * The body of each case must contain at least one executable statement.
 * No Implicit Fallthrough.
 */
var number = 0

switch number {
case 0:
    print("0")
case 1:
    print("1")
default:
    print("> 1")
}
//: ### Where & Value Bindings
number = 12

switch number {
case 0:
    print("0")
case let x where x % 2 == 0:
    print("\(number) is even")
default:
    print("\(number) is odd")
}
//: ### Interval Matching
number = 5
switch number {
case 0...5:
    print("0 <= x <= 5")
default:
    print("x >= 6")
}
//: ### Compound Cases
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
default:
    print("\(someCharacter) is not a vowel")
}
//: ### Compound cases can also include value bindings
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
/*:
 ## Control Transfer Statements
 * continue (A continue statement ends program execution of the current iteration of a loop statement but does not stop execution of the loop statement).
 * break (A break statement ends program execution of a loop, an if statement, or a switch statement).
 * fallthrough (A fallthrough statement continue execution from one case to the next of a switch).
 */

//: ## Labeled Statements
label1: while condition1 {
    while condition2 {
        if condition3 {
            continue label1
        }
        // do something
        
    }
}

label2: for i in 1...4 {
    // do something
}

label3: if condition1 {
    // do something
}
/*:
 ## Conditional Compilation Block
 
 Swift code can be conditionally compiled based on the evaluation of build configurations.
 
 Build configurations include:
 * the literal true and false values.
 * command line flags.
 * the platform-testing functions.
 * os()                Valid arguments: macOS, iOS, watchOS, tvOS.
 * arch()              Valid arguments: x86_64, arm, arm64, i386.
 * swift()             Valid arguments: >= followed by a version number.
 * canImport()         Valid arguments: A module name
 * targetEnvironment() Valid arguments: simulator
 
 The arch(arm) build configuration does not return true for ARM 64 devices.
 The arch(i386) build configuration returns true when code is compiled for the 32–bit iOS simulator.
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
//: [Next](@next)
