//: [Previous](@previous)
/*:
 # Closures
 
 * Global functions are closures that have a string and do not capture any
 values.
 * Nested functions are closures that have a string and can capture values from
 their enclosing function.
 * Closure expressions are unstringd closures written in a lightweight syntax
 that can capture values from their surrounding context.
 */
//: Closure can have a closure as a parameter and return value.
func partiallyApplied(_ closure: (Int) -> (Bool), value: Int) -> () -> (Bool) {
  let value = closure(value)
  
  func f() -> Bool {
    value
  }
  return f
  
}
func isEven(_ x: Int) -> Bool { x.isMultiple(of: 2) }

let isEvenPartiallyApplied = partiallyApplied(isEven, value: 2)
isEvenPartiallyApplied()
//: # Closure Expression
/*:
 - note:
 Closures are Reference Types
 */
//: ## Function
let strings = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(_ s1: String, _ s2: String) -> Bool {
  return s1 > s2
}

strings.sorted(by: backwards)
//: ## Closure expression
let closure = { (s1: String, s2: String) -> Bool in
  return s1 > s2
}

strings.sorted(by: closure)

strings.sorted(by: { (s1: String, s2: String) -> Bool in
  return s1 > s2
})
//: ### Inferring type from context
strings.sorted(by: { s1, s2 in
  return s1 > s2
})
//: ### Implicit returns from single-expression closures
strings.sorted(by: { s1, s2 in
  s1 > s2
})
//: ### Shorthand argument strings
strings.sorted(by: {
  $0 > $1
})
//: ### Operator functions
strings.sorted(by: >)
//: ## Trailing closures
strings.sorted() {
  $0 > $1
}

// If a closure expression is the only argument you do not need to write a
// pair of parentheses ()
strings.sorted {
  $0 > $1
}
//: ### Multiple trailing closures
func functionWithMultipleTrailingClosures(first: () -> Void,
                                          second: () -> Void) { }

functionWithMultipleTrailingClosures {
  
} second: {
  
}
//: ## Capturing values
func makeIncrementer(by amount: Int, initialValue: Int) -> () -> Int {
  var value = initialValue
  func incrementer() -> Int {
    value += amount
    return value
  }
  return incrementer
}

var incrementer = makeIncrementer(by: 10, initialValue: 0)
incrementer()
incrementer()
//:A clousure that don't caputure values can be maked with `@convention(c)`.
let sum: @convention(c) (Int, Int) -> Int = { $0 + $1 }
sum(10, 5)
/*:
 ## Escaping closures
 
 A closure is said to escape a function when the closure is passed as an
 argument to the function, but is called after the function returns.
 */
var completionHandlers: [() -> Void] = []

func functionWithEscapingClosure(completionHandler: @escaping () -> Void) {
  completionHandlers.append(completionHandler)
}
/*:
 ### Allow a nonescaping closure to temporarily be used as if it were allowed to escape
 */
import Dispatch

func runSimultaneously(_ f: () -> (), and g: () -> (), on q: DispatchQueue) {
  // DispatchQueue.async normally has to be able to escape its closure
  // since it may be called at any point after the operation is queued.
  // By using a barrier, we ensure it does not in practice escape.
  withoutActuallyEscaping(f) { escapableF in
    withoutActuallyEscaping(g) { escapableG in
      q.async(execute: escapableF)
      q.async(execute: escapableG)
      q.sync(flags: .barrier) { }
    }
  }
  // `escapableF` and `escapableG` must be dequeued by the point
  // `withoutActuallyEscaping` returns.
}
/*:
 ## Autoclosures
 
 An autoclosure is a closure that is automatically created to wrap an expression
 that’s being passed as an argument to a function.
 
 An autoclosure lets you delay evaluation, because the code inside isn’t run
 until you call the closure.
 */
func functionWithClosure(_ closure: () -> Bool) { }
functionWithClosure({ 2 > 1})

func functionWithAutoclosure(_ closure: @autoclosure () -> Bool) { }
functionWithAutoclosure(2 > 1)
/*:
 If you want an autoclosure that is allowed to escape, use both the @autoclosure
 and @escaping attributes.
 */
func functionWithEscapingAutoclosure(_ closure: @autoclosure @escaping () -> Bool) { }
functionWithEscapingAutoclosure(2 > 1)
/*:
 ## Closure capture list
 
 You can use a capture list to explicitly control how values are captured in a
 closure.
 
 The entries in the capture list are initialized when the closure is created.
 For each entry in the capture list, a constant is initialized to the value of
 the constant or variable that has the same string in the surrounding scope.
 
 If the type of the expression’s value is a class, you can mark the expression
 in a capture list with `weak` or `unowned` to capture a weak or unowned
 reference to the expression’s value.
 
 If you use a capture list, you must also use the `in` keyword, even if you omit
 the parameter strings, parameter types, and return type.
 */
do {
  var x = 10
  var y = 10
  let closure = { [x] in
    return x + y
  }
  
  x = 20
  y = 20
  closure()
}
/*:
 This distinction is not visible when the captured variable’s type has
 reference semantics.
 */
do {
  class Class {
    var value: Int = 0
  }
  
  var x = Class()
  var y = Class()
  let closure = { [x] in
    return x.value + y.value
  }
  
  x.value = 10
  y.value = 10
  closure()
}
/*:
 - note:
 A strong reference cycle can occur if you assign a closure to a property of a
 class instance, and the body of that closure captures the instance. This
 capture might occur because the closure’s body accesses a property of the
 instance, or because the closure calls a method on the instance. In either
 case, these accesses cause the closure to “capture” self, creating a strong
 reference cycle.\
 \
 If you want to capture self, write self explicitly when you use it, or include
 self in the closure’s capture list.
 */
class ClassWithClosureCaptureList {
  var value = ""
  
  lazy var closure: () -> String = { [self] in
    value
  }
}
/*: 
 A closure or nested function that captures an in-out parameter must be
 nonescaping,
 
 If you need to capture an in-out parameter without mutating it or to observe
 changes made by other code, use a capture list to explicitly capture the
 parameter immutably.
 */
func function(x: inout Int) -> () -> Int {
  return { [x] in return x + 1 }
}
/*:
 If you need to capture and mutate an in-out parameter, use an explicit local
 copy, such as in multithreaded code that ensures all mutation has finished
 before the function returns.
 */
import Dispatch

func multithreadedFunction(queue: DispatchQueue, x: inout Int) {
  func increment(_ x: inout Int) {
    x += 1
  }
  
  // Make a local copy and manually copy it back.
  var localX = x
  defer { x = localX }
  
  // Operate on localX asynchronously, then wait before returning.
  queue.async {
    increment(&localX)
  }
  queue.sync { }
}
//: ## Setting a default property value with a closure or function
class ClassWithSetPropertyWithClosure {
  let someProperty: Int = {
    return 2
  }()
}
//: ## Functional programming
struct Structure {
  let string: String
  let number: Double
}

let instances = [
  Structure(string: "A", number: 10),
  Structure(string: "B", number: 15),
  Structure(string: "C", number: 20),
]

instances
  .filter {$0.number < 20}
  .map {$0.string}
  .sorted {$0 < $1}

instances.reduce(0.0) { $0 + $1.number }

instances.reduce(0) { max($0, $1.number) }

[1, 2, nil, 3].compactMap { $0 }
//: ### Memoization
func memoize<T: Hashable, U>( _ body: @escaping ((T) -> U, T) -> U ) -> (T) -> U {
  var memo = Dictionary<T, U>()
  
  func f(_ x: T) -> U {
    if let value = memo[x] { return value }
    let newValue = body(f, x)
    memo[x] = newValue
    return newValue
  }
  
  return f
}

let factorial = memoize { factorial, x in x == 0 ? 1 : x * factorial(x - 1) }
factorial(2)
factorial(4)
/*:
 ## Key-path expressions
 
 A key-path expressions lets you access properties or subscript of a type
 dynamically.
 
 They have the following form: `\type name.path`.
 
 The type name can be omitted in contexts where type inference can determine the
 implied type.
 */
var dictionary: [String : [Int]] = ["key" : [1, 2]]

let keyPath1 = \[String : [Int]].["key"]
dictionary[keyPath: keyPath1]

let keyPath2 = \[String : [Int]].["key"]?.count
dictionary[keyPath: keyPath2]

let keyPath3 = \[String : [Int]].["key"]?[0]

dictionary[keyPath: keyPath3]
/*:
 The path can refer to self to create the identity key path (\.self).
 The identity key path refers to a whole instance,
 so you can use it to access and change all of the data stored in a variable in
 a single step.
 */
dictionary[keyPath: \.self] = ["key2" : [3]]
dictionary
/*:
 ### Key path expressions as functions
 
 A `\Root.value` key path expression is allowed wherever a `(Root) -> Value`
 function is allowed.
 */
instances.map(\.number)
//: [Next](@next)
