import Foundation
/*:
 # Interoperability
 
 In Objective-C you’ll have access to anything within a class or protocol that’s
 marked with the `@objc` attribute as long as it’s compatible with Objective-C.
 
 This excludes Swift-only features such as those listed here:
 * Generics.
 * Tuples.
 * Enumerations defined in Swift without Int raw value type.
 * Structures defined in Swift.
 * Top-level functions defined in Swift.
 * Global variables defined in Swift.
 * Typealiases defined in Swift.
 * Swift-style variadics.
 * Nested types.
 */
class Class : NSObject {
  
  init(property: String = "Hello") {
    self.property = property
  }
  
  // MARK: - property
  
  @objc var property: String
  
  // MARK: - bar
  
  @objc func bar() { }
  
  // MARK: - foo
  
  @objc func foo(_ value: Int) { }
  
  @objc(fooWithStrig:)
  func foo(_ value: String) { }
  
  @nonobjc
  func foo(_ value: Double) { }
  
  // MARK: - Class Method
  
  @objc class func classMethod() -> Int { 10 }
}

extension Class: NSCopying {
  func copy(with zone: NSZone? = nil) -> Any {
    Class(property: self.property)
  }
}

let instance = Class()
//: ## Selector expressions
#selector(getter: Class.property)
#selector(setter: Class.property)

#selector(Class.bar)
#selector(instance.bar)

#selector(Class.foo(_:) as (Class) -> (Int) -> Void)
#selector(Class.foo(_:) as (Class) -> (String) -> Void)
#selector(instance.foo(_:) as (String) -> Void)
/*:
 ## Key-path string expressions
 
 A key-path string expression lets you access the string used to refer to a
 property in Objective-C for use in key-value coding and key-value observing
 APIs.
 */
instance.value(forKey: #keyPath(Class.property))
/*:
 ## Optional Protocol Requirements
 
 When you use a method or property in an optional requirement, its type
 automatically becomes an optional. For example, a method of type
 `(Int) -> String` becomes `((Int) -> String)?`.
 
 Optional protocol requirements can only be specified if your protocol is
 marked with the `@objc` attribute.
 Note also that `@objc` protocols can be adopted only by classes that inherit
 from Objective-C classes or other `@objc` classes. They can’t be adopted by
 structures or enumerations.
 */
@objc protocol ProtocolWithOptionalRequirements {
  @objc optional func requirement1() -> Int
  @objc optional var requirement2: Int { get }
}

extension Class: ProtocolWithOptionalRequirements {
  var requirement2: Int { 0 }
}

var existential: any ProtocolWithOptionalRequirements = instance
existential.requirement1?()
existential.requirement2
/*:
 ## Requiring dynamic dispatch
 
 When Swift APIs are imported by the Objective-C runtime, there are no
 guarantees of dynamic dispatch for properties, methods, subscripts, or
 initializers. The Swift compiler may still devirtualize or inline member access
 to optimize the performance of your code, bypassing the Objective-C runtime.
 
 
 You can use the `dynamic` modifier to require that access to members be
 dynamically dispatched through the Objective-C runtime.
 */
extension Class {
  @objc dynamic func methodRequiringDynamicDispatch() { }
}
/*:
 ## Dynamic typing
 
 When you use `AnyObject` as a concrete type, you have at your disposal every
 `@objc` method and property that is, methods and properties imported from
 Objective-C or marked with the `@objc` attribute.
 
 These `@objc` symbols are available as implicitly unwrapped optional methods
 and properties, respectively.
 */
do {
  let anyObject: AnyObject = instance
  instance.property
  
  let anyClass: AnyClass = Class.self
  anyClass.classMethod()
}
/*:
 ## Infer @objc
 
 `@objc` is inferred when:
 * the declaration is an override of an `@objc` declaration,
 * the declaration satisfies a requirement in an `@objc` protocol,
 * the declaration has one of the following attributes: `@IBAction`,
 `@IBOutlet`, `@IBInspectable`, `@GKInspectable`, or `@NSManaged`.
 */
/*:
 ## @NSCopying
 
 Apply this attribute to a stored variable property of a class. This attribute
 causes the property’s setter to be synthesized with a copy of the property’s
 value—returned by the `copyWithZone(_:)` method—instead of the value of the
 property itself. The type of the property must conform to the `NSCopying`
 protocol.
 */
class ClassWithNSCopying {
  @NSCopying var object: Class?
}

do {
  let object = Class()
  let instance = ClassWithNSCopying()
  instance.object = object
  
  object.property = ""
  instance.object?.property
}
