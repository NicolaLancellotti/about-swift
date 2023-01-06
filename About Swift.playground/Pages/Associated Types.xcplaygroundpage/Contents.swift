//: [Previous](@previous)
/*:
 # Associated types
 
 An associated type gives a placeholder name to a type that is used as part of the protocol.
 */
protocol ProtocolWithAssociatedType<A, B /*Primary Associated Types*/> {
  associatedtype A
  associatedtype B
  associatedtype C
  
  func foo() -> A
}

struct SomeStructure: ProtocolWithAssociatedType {
  typealias A = Int  // Infer from context
  typealias B = Bool
  typealias C = Double
  
  func foo() -> A { 0 }
}

let x1: any ProtocolWithAssociatedType = SomeStructure()
let _: Any = x1.foo()
//: ### Constrained Existential Types
let x2: any ProtocolWithAssociatedType<Int, Bool> = SomeStructure()
let _: Int = x2.foo()
/*:
 ## Where Clauses
 
 A generic where clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same.
 */
func bar1<P1, P2, T>(x: P1, y: P2, z: T)
where P1: ProtocolWithAssociatedType,
      P2: ProtocolWithAssociatedType,
      P1.A == P2.A,
      P1.A: Sequence,
      P1.A.Element == T,
      P1.B == P2.B,
      P1.B == Bool { }

// is the same of
func bar2<T>(x: any ProtocolWithAssociatedType<any Sequence<T>, Bool>,
             y: any ProtocolWithAssociatedType<any Sequence<T>, Bool>,
             z: T) { }
//: ## Protocol Extensions
extension ProtocolWithAssociatedType where A == Int, B == Bool { }
// is the same of
extension ProtocolWithAssociatedType<Int, Bool> {}


extension ProtocolWithAssociatedType where A: Equatable, B == Bool { }
// is the same of
extension ProtocolWithAssociatedType<Equatable, Bool> {}
//: ## Inherited Protocols
protocol InheritedProtocol1: ProtocolWithAssociatedType where A: Comparable, B == Bool {}
// is the same of
protocol InheritedProtocol2: ProtocolWithAssociatedType<Comparable, Bool> {}
//: ## Inheritance clause of an associated type
protocol ProtocolInheritanceClause1  {
  associatedtype Value: ProtocolWithAssociatedType where Value.A: Comparable, Value.B == Bool
}
// is the same of
protocol ProtocolInheritanceClause2  {
  associatedtype Value: ProtocolWithAssociatedType<Comparable, Bool>
}
//: [Next](@next)
