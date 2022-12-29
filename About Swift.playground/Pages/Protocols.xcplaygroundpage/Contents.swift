//: [Previous](@previous)
/*:
 # Protocols
 
 A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.
 */
/*:
 - note:
 `Self` refers to the eventual type that conforms to the protocol.
 */
/*:
 ## Property Requirements
 
 * Instance property.
 * Type property.
 
 Doesn’t specify whether the property should be a stored property or a computed property.
 */
protocol ProtocolWithPropertyRequirements {
  // Property requirements are always declared as variable properties.
  var mustBeSettable: Int { get set }
  var doesNotNeedToBeSettable: Int { get }
  
  // Always prefix type property requirements with the static keyword.
  static var someTypeProperty: Int { get set }
}
/*:
 ## Subscript Requirements
 */
protocol ProtocolWithSubscriptRequirements {
  subscript(index: Int) -> Int { get set }
}
/*:
 ## Method Requirements
 
 * Default values cannot be specified for method parameters within a protocol’s definition.
 * You always prefix type method requirements with the static keyword.
 
 * If you define a protocol instance method requirement that is intended to mutate instances of any type that adopts the protocol, mark the method with the mutating keyword as part of the protocol’s definition.
 */
protocol ProtocolWithMethodRequirements {
  func method() -> Self
  
  mutating func mutatingMethod()
  
  static func staticMethod()
}
/*:
 ## Initializer Requirements
 
 You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier.
 
 You do not need to mark protocol initializer implementations with the required modifier on classes that are marked with the final modifier, because final classes cannot be subclassed.
 
 If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the required and override modifiers.
 
 A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer.
 */
protocol ProtocolWithInitializerRequirements {
  init(value: Bool) // mark with required in a class implementation
}
/*:
 ## Protocol Inheritance
 
 A protocol can inherit one or more other protocols and can add further requirements on top of the requirements it inherits.
 */
protocol InheritingProtocol: ProtocolWithInitializerRequirements,
                             ProtocolWithMethodRequirements { }
//: A Protocol can  constrain their conforming types to those that subclasses a given class.
class SomeClass { }

protocol SomeClassSubclassOnlyProtocol : SomeClass { }

// The same as:
// protocol SomeClassSubclassOnlyProtocol where Self : SomeClass { }

class SomeSubclass: SomeClass, SomeClassSubclassOnlyProtocol { }
// class SomeSubclass1: SomeClassSubclassOnlyProtocol{ } // Error
/*:
 ## Class-Only Protocols
 
 You can limit protocol adoption to class types (and not structures or enumerations) by adding the class keyword to a protocol’s inheritance list. The class keyword must always appear first in a protocol’s inheritance list, before any inherited protocols.
 */
protocol SomeClassOnlyProtocol: AnyObject, ProtocolWithInitializerRequirements { }
/*:
 ## Protocol Composition
 
 It can be useful to require a type to conform to multiple protocols at once. You can combine multiple protocols into a single requirement with a protocol composition.
 
 A protocol composition can also contain one class type, which you can use to specify a required superclass.
 */
protocol SomeProtocol { }

let object1: any SomeProtocol

let object2: any SomeProtocol & SomeClassOnlyProtocol
//: [Next](@next)
