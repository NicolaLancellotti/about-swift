//: [Previous](@previous)
/*:
 # Associated types
 
 An associated type gives a placeholder name to a type that is used as part of the protocol.
 */
protocol ProtocolWithAssociatedType {
  associatedtype Item
  
  func foo() -> Item
}

struct SomeStructure: ProtocolWithAssociatedType {
  typealias Item = Int  // Infer from contex
  
  func foo() -> Item { 0 }
}
/*:
 ## Where Clauses
 
 A generic where clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same.
 */
func bar<P1, P2, T>(x: P1, y: P2, z: T)
where P1: ProtocolWithAssociatedType,
      P2: ProtocolWithAssociatedType,
      P1.Item == P2.Item,
      P1.Item: Sequence,
      P1.Item == T { }
//: ## Protocol Extensions with a Generic Where Clause
extension ProtocolWithAssociatedType where Item: Equatable { }

extension ProtocolWithAssociatedType where Item == Int { }
//: ## Inherited Protocols with a Generic Where Clause
protocol P1: ProtocolWithAssociatedType where Item: Comparable {
  associatedtype Value
}
//: ## Associated Types with a Generic Where Clause
protocol P2  {
  associatedtype Value: ProtocolWithAssociatedType where Value.Item: Comparable
}
//: [Next](@next)
