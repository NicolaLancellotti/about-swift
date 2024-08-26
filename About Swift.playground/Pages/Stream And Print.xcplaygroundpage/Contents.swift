//: [Previous](@previous)
//: # Stream And Print
//: ## Print
print("A", "B", "C", separator: "-", terminator: "|END\n")
//: ## ReadLine
// let line  = readline()
/*:
 ## TextOutputStreamable
 
 A source of text-streaming operations.
 */
var stream = String()

"Hello,".write(to: &stream)
" world!".write(to: &stream)
stream
/*:
 ## TextOutputStream
 
 A type that can be the target of text-streaming operations.
 You can send the output of the standard library’s `print(_:to:)` and
 `dump(_:to:)` functions to an instance of a
 type that conforms to the TextOutputStream protocol instead of to standard
 output.
 */
stream = String()
print("Hello, world!", to: &stream)
stream
//: [Next](@next)
