//: [Previous](@previous)

//: # Library Functions

//: ## Input / Output
print("A", "B", "C", separator: "-", terminator: "END")
//let line  = readline()
//: ## Math
abs(-10)
max(1, 2, 3)
min(1, 2, 3)

var a = 1
var b = 2
swap(&a, &b)
a
b
//: ## Cast

/*: 
 ### Unsafe Bit Cast
 
 Returns the bits of x, interpreted as having type U.
 */
let v: Double = 1024
unsafeBitCast(v, to: UInt.self)
let uint: UInt64 = 0b0100000010010000000000000000000000000000000000000000000000000000

/*: 
 ### Numeric Cast
 
 Typically used to do conversion to any contextually-deduced integer type.
 */

func f(_ x: Int32) {
}

func g(_ x: UInt64) {
    f(numericCast(x))
}


//: ## Repeat Element
let elements = repeatElement(1, count: 5)
elements.count
//: ## Zip
var sequence1 = ["a" , "b"]
let sequence2 = [1, 2]

for (a, b) in zip(sequence1, sequence2) {
    //print("\(a) \(b)")
}


//: [Next](@next)
