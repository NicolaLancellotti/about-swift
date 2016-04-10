//: [Previous](@previous)

//: # Control Flow
let condition1 = false
let condition2 = false

//: ## For-In

//: 0 <= i <= 4
for i in 0...4  {
    
}

//: 0 <= i < 4
for i in 0..<4 {
    
}

//: i = 0, 2, 4
for i in 0...4 where i % 2 == 0 {
}


//: ## While Loops

//: ### While

while condition1 {
    
}

//: ### Repeat-While
repeat {
    
} while condition1

//: ## Conditional Statements

//: ### If
if condition1 {
    
} else if condition2 {
    
} else {
    
}

/*:
 ### Switch
 * Every switch statement must be exhaustive.
 * The body of each case must contain at least one executable statement.
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

//: Where & Value Bindings
number = 12

switch number {
case 0:
    print("0")
case let x where x % 2 == 0:
    print("\(number) is even")
default:
    print("\(number) is odd")
}


//: Interval Matching
number = 5
switch number {
case 0...5:
    print("0 <= x <= 5")
default:
    print("x >= 6")
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
        continue label1
    }
}

label2: for i in 1...4 {
    
}

label3: if condition1 {
    
}


/*:
 ## Build Configurations
 
 Swift code can be conditionally compiled based on the evaluation of build configurations.
 
 Build configurations include:
 * the literal true and false values.
 * command line flags.
 * the platform-testing functions.
 * os()      Valid arguments: OSX, iOS, watchOS, tvOS.
 * arch()    Valid arguments: x86_64, arm, arm64, i386.
 * swift()   Valid arguments: >= followed by a version number.
 
 The arch(arm) build configuration does not return true for ARM 64 devices.
 The arch(i386) build configuration returns true when code is compiled for the 32–bit iOS simulator.
 */



#if os(OSX)
    
#elseif arch(arm)
    
#elseif swift(>=2.1)
    
#elseif !condition1
    
#else
    
#endif


//: [Next](@next)
