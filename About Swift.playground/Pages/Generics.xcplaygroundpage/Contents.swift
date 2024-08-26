//: [Previous](@previous)
//: # Generics
/*:
 ## Generic functions
 
 The placeholder type `T` is an example of a type parameter.
 
 You can provide more than one type parameter by writing multiple type parameter
 names within the angle brackets, separated by commas.
 */
func mySwap<T>(_ x: inout T, _ y: inout T) {
  (x, y) = (y, x)
}

do {
  var x = "x"
  var y = "y"
  mySwap(&x, &y)
  x
  y
}

/*:
 ## Type constraint
 
 Type constraints specify that a type parameter must inherit from a specific
 class, or conform to a particular protocol or protocol composition.
 */
protocol Protocol1 { }
protocol Protocol2 { }
class Class1 { }

func funcWithTypeConstraint<P: Protocol1 & Protocol2, C: Class1>(x: P, y: C) { }
//: ## Generic where clauses
func funcWithGenericWhereClause<P, C>(x: P, y: C) where P: Protocol1 & Protocol2, C: Class1 { }
//: ## Generic types
enum LinkedList<Element> {
  case empty
  indirect case cons(Element, LinkedList<Element>)
  
  mutating func pushFront(_ elem: Element) {
    self = .cons(elem, self)
  }
  
  subscript(index: Int) -> Element? {
    switch self {
      case .empty: nil
      case let .cons(elem, next): index == 0 ? elem : next[index - 1]
    }
  }
  
  subscript<Indices: Sequence>(indices: Indices) -> [Element?]
  where Indices.Iterator.Element == Int {
    return indices.map {self[$0]}
  }
  
  func sum() -> Int where Element == Int {
    switch self {
      case .empty: 0
      case let .cons(elem, next): elem + next.sum()
    }
  }
  
}

var list: LinkedList<Int> = .cons(0, .cons(1, .empty))
list.pushFront(-1)
list[0]
list[1]
list[2]
list[3]
list[1...3]
//: ## Extensions of generic types
extension LinkedList {
  var top: Element? {
    switch self {
      case .empty: nil
      case .cons(let elem, _): elem
    }
  }
}
//: ## Extensions on bound generic types
extension LinkedList<String> {
  func topReversed() -> String? {
    switch self {
      case .empty: nil
      case .cons(let elem, _): String(elem.reversed())
    }
  }
}
//: ## Extensions with a generic where clause
extension LinkedList where Element: Equatable {
  func isTop(_ item: Element) -> Bool {
    switch self {
      case .empty: false
      case .cons(let elem, _): elem == item
    }
  }
}
//: ## Conditionally conforming to a protocol
extension LinkedList: Equatable where Element: Equatable {
  static func == (lhs: LinkedList<Element>, rhs: LinkedList<Element>) -> Bool {
    switch (lhs, rhs) {
      case (.empty, .empty): true
      case let (.cons(x, nextX), .cons(y, nextY)) where x == y: nextX == nextY
      default: false
    }
  }
}

var list1: LinkedList<Int> = .cons(0, .cons(1, .empty))
var list2: LinkedList<Int> = .cons(0, .cons(1, .empty))
list1 == list2
/*:
 ## Nested generic types
 
 Nested types may appear inside generic types, and nested types may have their
 own generic parameters.
 */
struct OuterNonGeneric {
  struct InnerGeneric<T> { }
}

struct OuterGeneric<T> {
  struct InnerNonGeneric { }
  
  struct InnerGeneric<P> { }
}
/*:
 ## Value and type parameter packs
 */
/*
 Nomenclature
 
 repeat (each T, each U)
 _______________________
 pack expansion type
        ________________
        repetition pattern
         ______  ______
         captured type parameter packs
 */
func zip< /* type parameter pack: */ each T, /* type parameter pack: */ each U>
(
  /* value parameter pack: */ values: /* pack expansion type: */ repeat each T,
                              tuple: /* abstract tuple type: */ (repeat each U)
) -> (repeat (each T, each U)) {
  return /* pack expansion expression: */ (repeat (each values, each tuple))
}

zip(values: /* value pack: */ 1, "a", tuple: /* abstract tuple value: */ ("a", 1))
//: ### Variadic types
struct VariadicType< /* generic parameter pack: */ each T, U> {
  var values: /* tuple type of pack expansion type: */ (repeat each T)
  var value: U
}

VariadicType(values: (1, "a"), value: true)
//: ## Dispaching
struct GenericStruct<T> {
  var property: String { "Generic" }
}

extension GenericStruct where T == Int {
  var property: String { "Int" }
}

extension GenericStruct where T: Equatable {
  var property: String { "Equatable" }
}

func dispachGeneric<T>(_ x: GenericStruct<T>) -> String { x.property }

func dispachInt(_ x: GenericStruct<Int>) -> String { x.property }

func dispachEquatable<T: Equatable>(_ x: GenericStruct<T>) -> String { x.property }

let value = GenericStruct<Int>()
value.property
dispachGeneric(value)
dispachInt(value)
dispachEquatable(value)
/*:
 ## Implicitly opened existentials
 This operates by "opening" the value of protocol type and passing the
 underlying type directly to the generic function.
 */
do {
  struct Structure1: Protocol1 {}

  func f<T>(_ value: T) -> String { "f<T>" }

  func f<T: Protocol1>(_ value: T) -> String { "f<T: Protocol1>" }
  
  let value: any Protocol1 = Structure1()
  f(value) == "f<T: Protocol1>"
  f(value as any Protocol1) == "f<T>" // suppresses opening
  f((value as any Protocol1)) == "f<T: Protocol1>" // parentheses disable the suppression mechanism
}
/*:
 ## Static member lookup in generic contexts
 It is possible to use leading-dot syntax in generic contexts to access static
 members of protocol extensions where Self is constrained to a fully concrete
 type.
 */
protocol ProtocolWithExtension {  }

struct Structure: ProtocolWithExtension { }

extension ProtocolWithExtension where Self == Structure {
  static func initializer() -> Self { .init() }
}

func foo<T: ProtocolWithExtension>(_ value: T) { }

foo(.initializer()) // Static Member Lookup
//: [Next](@next)
