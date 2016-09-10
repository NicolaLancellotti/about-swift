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
let elements = repeatElement(1, count: 5)
elements.count
//: ## Zip
var sequence1 = ["a" , "b"]
let sequence2 = [1, 2]

for (a, b) in zip(sequence1, sequence2) {
    //print("\(a) \(b)")
}


//: [Next](@next)
