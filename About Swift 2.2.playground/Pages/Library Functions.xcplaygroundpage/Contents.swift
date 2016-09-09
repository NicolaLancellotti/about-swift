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
//: ## Repeat Element
let elements = repeatElement(1, count:5)
elements.count
//: ## Zip
var sequence1 = ["a" , "b"]
let sequence2 = [1, 2]

for (a, b) in zip(sequence1, sequence2) {
    //print("\(a) \(b)")
}
//: ## Unsafe Bit Cast
let v: Double = 1024
unsafeBitCast(v, to: UInt.self)
let uint: UInt64 = 0b0100000010010000000000000000000000000000000000000000000000000000
//: ## Memory
struct Structure {
    let value2: Int32 = 0
    let value0: Int16 = 0
    let value1: Int8 = 0
}

let instance = Structure()

// Returns the contiguous memory footprint of T.
// Do not include any padding necessary for memory alignment.
MemoryLayout<Structure>.size

// Returns the minimum memory alignment of T.
// An alignment of x means that data of this type should (or must, depends on
// the CPU) be stored starting at an address that is a multiple of x.
MemoryLayout<Structure>.alignment

// Returns the least possible interval between distinct instances of T in memory.
// Like sizeof operator in C
MemoryLayout<Structure>.stride

class SomeClass { }
let object = SomeClass()
//: [Next](@next)
