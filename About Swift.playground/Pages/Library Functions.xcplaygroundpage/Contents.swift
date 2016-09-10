//: [Previous](@previous)

//: # Library Functions

//: ## Input / Output
print("A", "B", "C", separator: "-", terminator: "END")
//let line  = readline()
print("\n")
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
let elements = repeatElement(1, count: 5)
elements.count



//: [Next](@next)
