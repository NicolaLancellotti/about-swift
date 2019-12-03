//: [Previous](@previous)

//: # Generics

/*:
 ## Generic Functions
 
 The placeholder type T is an example of a type parameter.
 
 You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.
 */
func mySwap<T>(_ a: inout T, _ b: inout T) {
  (a, b) = (b, a)
}

var a = "A"
var b = "B"
mySwap(&a, &b)
b
a

swap(&a, &b) // Swap function in the Standard Library

/*:
 ## Type Constraint
 
 Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.
 */
protocol P1 { }
protocol P2 { }
class C1 { }

func foo1<P: P1 & P2, C: C1>(x: P, y: C) {}
//: ## Generic Where Clauses
func foo2<P, C>(x: P, y: C) where P: P1 & P2, C: C1 {}
//: ## Generic Types
enum LinkedList<Element> {
  case empty
  indirect case cons(Element, LinkedList<Element>)
  
  mutating func pushFront(_ elem: Element) {
    self = .cons(elem, self)
  }
  
  subscript(index: Int) -> Element? {
    switch self {
      case .empty: return nil
      case let .cons(elem, next): return index == 0 ? elem : next[index - 1]
    }
  }
  
  subscript<Indices: Sequence>(indices: Indices) -> [Element?]
    where Indices.Iterator.Element == Int {
      return indices.map {self[$0]}
  }
  
}

var list: LinkedList<Int> = .cons(0, .cons(1, .empty))
list.pushFront(-1)
list[0]
list[1]
list[2]
list[3]
list[1...3]
//: ## Extensions of Generic Types
extension LinkedList {
  
  var top: Element? {
    switch self {
      case .empty: return nil
      case .cons(let elem, _): return elem
    }
  }
  
}
list.top!
//: ## Extensions with a Generic Where Clause
extension LinkedList where Element: Equatable {
  func isTop(_ item: Element) -> Bool {
    switch self {
      case .empty: return false
      case .cons(let elem, _): return elem == item
    }
  }
}

extension LinkedList where Element == Int {
  func sum() -> Int {
    switch self {
      case .empty: return 0
      case let .cons(elem, next): return elem + next.sum()
    }
  }
}
//: ## Conditionally Conforming to a Protocol
extension LinkedList: Equatable where Element: Equatable {
  static func == (lhs: LinkedList<Element>, rhs: LinkedList<Element>) -> Bool {
    switch (lhs, rhs) {
      case (.empty, .empty): return true
      case let (.cons(x, nextX), .cons(y, nextY)) where x == y: return nextX == nextY
      default: return false
    }
  }
}

var list1: LinkedList<Int> = .cons(0, .cons(1, .empty))
var list2: LinkedList<Int> = .cons(0, .cons(1, .empty))
list1 == list2
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
 ## Dispaching
 */
struct GenericStruct<T> {
  var foo: String {
    return "generic foo"
  }
}

extension GenericStruct where T == Int {
  var foo: String {
    return "int foo"
  }
}

extension GenericStruct where T: Equatable {
  var foo: String {
    return "equatable foo"
  }
}

func f1<T>(_ x: GenericStruct<T>) -> String {
  return x.foo
}

func f2(_ x: GenericStruct<Int>) -> String {
  return x.foo
}

func f3<T: Equatable>(_ x: GenericStruct<T>) -> String {
  return x.foo
}

let value = GenericStruct<Int>()
value.foo
f1(value)
f2(value)
f3(value)
//: [Next](@next)
