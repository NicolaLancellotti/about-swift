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
    associatedtype Item
    
    mutating func append(_ item: Item)
    
    var count: Int { get }
    
    subscript(i: Int) -> Item { get }
}

struct SomeStructure: Container {
    
    var items = [Int]()
    
    //    typealias Item = Int  // Infer from contex
    
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
 ## Nested Generic Types
 
 Nested types may appear inside generic types, and nested types may have their own generic parameters.
 */
struct OuterNonGeneric {
    struct InnerGeneric<T> {}
}

struct OuterGeneric<T> {
    struct InnerNonGeneric {}
    
    struct InnerGeneric<T> {}
}
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
    where C1.Item == C2.Item, C1.Item: Equatable {
    
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

//: ## Extensions with a Generic Where Clause
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}


extension Collection where Iterator.Element: Equatable {
    func startsWith(_ item: Iterator.Element) -> Bool {
        guard let first = first else {
            return false
        }
        return first == first
    }
}

extension Collection where Iterator.Element == Double {
    func sum() -> Double {
        return reduce(0.0, +)
    }
}
/*:
 ### Generic Subscripts
 */
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
//: [Next](@next)
