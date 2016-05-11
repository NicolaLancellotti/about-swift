//: [Previous](@previous)
import Foundation
/*:
 # Closures
 
 * Global functions are closures that have a name and do not capture any values.
 
 * Nested functions are closures that have a name and can capture values from their enclosing function.
 
 * Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
 */

/*:
 - note:
 Closures are Reference Types
 */

//: ### The type of a closure is a tuple
func doSomething(par1: Int, par2: Bool) {
    
}
let func1: (Int, Bool) -> () = doSomething
func1(1, true)

//: ### Closure can have a closure as a parameter
func funcWithFuncParam(closure: (Int, Bool) -> ()) {
    
}
funcWithFuncParam(func1)


//: ### Closure can return a closure
func funcWithFuncReturn(flag: Bool) -> ((Int) -> Int)? {
    if flag {
        func function(value: Int) -> Int {
            return value + 1
        }
        return function
    } else {
        return nil
    }
}


//: # Closure Expression

//: ## Function

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]


func backwards(s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

names.sort(backwards)

//: ## Closure Expression
let closure = { (s1: String, s2: String) -> Bool in
    return s1 > s2
}

names.sort(closure)


names.sort({ (s1: String, s2: String) -> Bool in
    return s1 > s2
})

//: ### Inferring Type From Context
names.sort({ s1, s2 in
    return s1 > s2
})

//: ### Implicit Returns from Single-Expression Closures
names.sort({ s1, s2 in
    s1 > s2
})

//: ### Shorthand Argument Names
names.sort({
    $0 > $1
})

//: ### Operator Functions
names.sort(>)

//: ## Trailing Closures
names.sort() {
    $0 > $1
}
//If a closure expression is the only argument you do not need to write a pair of parentheses ()

names.sort {
    $0 > $1
}

//: ## Capturing Values
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}


var closure1 = makeIncrementer(forIncrement: 10)
closure1()
closure1()

var closure2 = makeIncrementer(forIncrement: 50)
closure2()
closure2()

/*:
 ## Nonescaping Closures
 
 A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns.
 */
func someFunctionWithNoescapeClosure(@noescape closure: () -> Void) {
    closure()
}
/*:
 ## Autoclosures
 
 An autoclosure is a closure that is automatically created to wrap an expression that’s being passed as an argument to a function.
 
 The @autoclosure attribute implies the @noescape attribute, if you want an autoclosure that is allowed to escape, use the @autoclosure(escaping).
 */

func functionWithAutoclosure(@autoclosure closure: () -> Bool) {
}
functionWithAutoclosure(2 > 1)


func functionWithClosure(closure: () -> Bool) {
}

functionWithClosure({ () -> Bool in
    return 2 > 1
})

/*:
 ##  Closure capture list

 You can use a capture list to explicitly control how values are captured in a closure.
 
 The entries in the capture list are initialized when the closure is created. For each entry in the capture list, a constant is initialized to the value of the constant or variable that has the same name in the surrounding scope.
 
 If the type of the expression’s value is a class, you can mark the expression in a capture list with `weak` or `unowned` to capture a weak or unowned reference to the expression’s value.

 If you use a capture list, you must also use the `in` keyword, even if you omit the parameter names, parameter types, and return type.
 
 */
var a = 0
var b = 0
let closure4 = { [a] in
    print(a, b)
}

a = 10
b = 10
closure4() // Prints "0 10"

//:This distinction is not visible when the captured variable’s type has reference semantics.

class SimpleClass {
    var value: Int = 0
}
var x = SimpleClass()
var y = SimpleClass()
let closure5 = { [x] in
    print(x.value, y.value)
}

x.value = 10
y.value = 10
closure5() // Prints "10 10"

/*:
 - note:
 A strong reference cycle can occur if you assign a closure to a property of a class instance, and the body of that closure captures the instance. This capture might occur because the closure’s body accesses a property of the instance, or because the closure calls a method on the instance. In either case, these accesses cause the closure to “capture” self, creating a strong reference cycle.\
 \
 Swift requires you to write self.someProperty or self.someMethod() (rather than just someProperty or someMethod()) whenever you refer to a member of self within a closure. This helps you remember that it’s possible to capture self by accident.
 */

class ClassWithClosureCaptureList {
    
    var value = ""
    
    lazy var someClosure: () -> () = {
        [unowned self] in
        print(self.value)
    }
    
}

//: ## Setting a Default Property Value with a Closure or Function
class ClassWithSetPropertyWithClosure {
    let someProperty: Int = {
        return 2
    }()
}

//: ## Functional Programming

struct Person {
    let name: String
    let age: Double
}

let people = [
    Person(name: "Nicola", age: 7),
    Person(name: "Ilenia", age: 9),
    Person(name: "Claudia", age: 8),
    Person(name: "Angela", age: 10)
]

let sortedChildrenNames = people.filter {$0.age < 10} .map {$0.name} .sort {$0 < $1}
sortedChildrenNames

let averageAge = people.reduce(0.0) { $0 + $1.age } / Double(people.count)
averageAge

let maxAge = people.reduce(0) { max($0, $1.age) }
maxAge


//: Memoization

func memoize<T: Hashable, U>( body: ((T)->U, T)->U ) -> (T)->U {
    var memo = Dictionary<T, U>()
    
    func result(x: T) -> U {
        if let q = memo[x] { return q }
        let r = body(result, x)
        memo[x] = r
        print("memo.count: \(memo.count)")
        return r
    }
    
    return result
}

let factorial = memoize { factorial, x in x == 0 ? 1 : x * factorial(x - 1) }
print("\nFactorial of: 2")
factorial(2)
print("\nFactorial of: 4")
factorial(4)



//: [Next](@next)
