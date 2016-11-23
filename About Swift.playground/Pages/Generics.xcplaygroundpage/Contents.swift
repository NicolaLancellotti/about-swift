//: [Previous](@previous)

/*:
 # Generics
 
 Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define.
 
 */

/*:
 ## Functions
 
 The placeholder type T is an example of a type parameter.
 
 You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.
 */
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var a = "A"
var b = "B"
swapTwoValues(&a, &b)
b
a

swap(&a, &b) // Swap function in the Standard Library
//: ## Structures and Classes
struct Stack<Element> {
    
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
}

extension Stack {
    
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
    
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("Ciao")
/*:
 ## Protocols
 */
protocol Container {
    
    //  An associated type gives a placeholder name to a type that is used as part of the protocol.
    associatedtype ItemType
    
    mutating func append(_ item: ItemType)
    
    var count: Int { get }
    
    subscript(i: Int) -> ItemType { get }
}

struct SomeStructure: Container {
    
    var items = [Int]()
    
    //    typealias ItemType = Int  // Infer from contex
    
    mutating func append(_ item: Int) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
    
}
/*:
 ### Type Erasure
 */
protocol Incrementable {
    
    associatedtype T
    var current: T { get }
    mutating func increment() -> T
    func incremented(by value: T) -> Self
}

struct IncrementerBy1: Incrementable {
    
    private(set) var current: Int
    
    mutating func increment() -> Int {
        current += 1
        return current
    }
    func incremented(by value: Int) -> IncrementerBy1 {
        return IncrementerBy1(current: self.current + value)
    }
}

struct IncrementerBy2: Incrementable {
    
    private(set) var current: Int
    
    mutating func increment() -> Int {
        current += 2
        return current
    }
    func incremented(by value: Int) -> IncrementerBy2 {
        return IncrementerBy2(current: self.current + value)
    }
}
/*:
 - note:
 You cannot write: \
 `var incrementer: Incrementable`
 */
struct AnyIncrementable<T>: Incrementable {
    
    private var _current: () -> T
    private let _increment: () -> T
    private let _incremented: (T) -> AnyIncrementable<T>
    
    init<I: Incrementable>(_ instance: I) where I.T == T  {
        var i = instance
        _current = { i.current }
        _increment = { i.increment() }
        _incremented =  { AnyIncrementable(i.incremented(by: $0)) }
    }
    
    var current: T {
        return _current()
    }
    
    mutating func increment() -> T {
        return _increment()
    }
    
    func incremented(by current: T) -> AnyIncrementable<T> {
        return _incremented(current)
    }
    
}

var incrementer: AnyIncrementable<Int>

incrementer = AnyIncrementable(IncrementerBy1(current: 0))
incrementer.increment()
incrementer.increment()
incrementer.incremented(by: 10).current

incrementer = AnyIncrementable(IncrementerBy2(current: 0))
incrementer.increment()
incrementer.increment()
incrementer.incremented(by: 10).current
/*:
 ## Type Constraint
 
 Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.
 */
class SomeClass {}
protocol SomeProtocol{}

func someFunction<T: SomeClass, U: SomeProtocol>(_ someT: T, someU: U) {
    
}

func findIndex<T: Equatable>(_ array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
/*:
 ### Where Clauses
 
 It can also be useful to define requirements for associated types. You do this by defining a generic where clause.
 A generic where clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same.
 */
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
    
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}
//: [Next](@next)
