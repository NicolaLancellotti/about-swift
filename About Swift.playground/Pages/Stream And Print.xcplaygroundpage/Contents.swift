//: [Previous](@previous)

import Foundation

//: # Stream And Print

//: ## Print
print("A", "B", "C", separator: "-", terminator: "|END\n")
//: ## ReadLine
//let line  = readline()
/*:
 ## Dump
 
 Dumps an object’s contents using its mirror to standard output.
 */
class SomeClass {
    var classValue0 = "a string"
    var classValue1 = SomeStructure()
    
    struct SomeStructure {
        var structValue0 =  10
    }
}

let instance = SomeClass()
dump(instance)
/*:
 ## TextOutputStreamable
 A source of text-streaming operations.
 */
var stream = String()

"Ciao".write(to: &stream)
" mondo!".write(to: &stream)
stream
/*:
 ## TextOutputStream
 A type that can be the target of text-streaming operations.
 You can send the output of the standard library’s `print(_:to:)` and `dump(_:to:)` functions to an instance of a
 type that conforms to the TextOutputStream protocol instead of to standard output.
 */
stream = String()
print("Hello, world!", to: &stream)
stream
//: [Next](@next)
