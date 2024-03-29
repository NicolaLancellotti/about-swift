
import Foundation

/*:
 # Interoperability
 
 In Objective-C you’ll have access to anything within a class or protocol that’s marked with the
 @objc attribute as long as it’s compatible with Objective-C.
 
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
//: ## Selector Conflicts
class SomeClass : NSObject {
  @objc var someProperty: String = "Hello"
  
  @objc func foo(_ value: Int) { }
  
  @objc(fooWithStrig:)
  func foo(_ value: String) { }
  
  @nonobjc
  func foo(_ value: Double) { }
}

let instance = SomeClass()
//: ## Selector Expression
extension SomeClass {
  @objc func bar() { }
  
  @objc func foobar(value: Int) { }
}

let selectorForPropertyGetter = #selector(getter: SomeClass.someProperty)
let selectorForPropertySetter = #selector(setter: SomeClass.someProperty)

let selectorForMethodBar = #selector(SomeClass.bar)
let selectorForMethodFoobar = #selector(SomeClass.foobar(value:))

let selectorForMethodFooString = #selector(SomeClass.foo(_:) as (SomeClass) -> (String) -> Void)
let selectorForMethodFooDouble = #selector(SomeClass.foo(_:) as (SomeClass) -> (Int) -> Void)

let selectorForMethodBar2 = #selector(instance.bar)
let selectorForMethodFooString2 = #selector(instance.foo(_:) as (String) -> Void)
/*:
 ## Key-Path String Expression
 
 A key-path string expression lets you access the string used to refer to a property in Objective-C for use in key-value coding and key-value observing APIs.
 */
let keyPath: String = #keyPath(SomeClass.someProperty)
instance.value(forKey: keyPath)
/*:
 ## Optional Protocol Requirements
 
 When you use a method or property in an optional requirement, its type automatically becomes an optional. For example, a method of type (Int) -> String becomes ((Int) -> String)?.
 
 Optional protocol requirements can only be specified if your protocol is marked with the @objc attribute.
 Note also that @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.
 */
@objc protocol CounterDataSource {
  @objc optional func increment(forCount count: Int) -> Int
  @objc optional var fixedIncrement: Int { get }
}

class ThreeSource: NSObject, CounterDataSource {
  let fixedIncrement = 3
}

class Counter {
  var count = 0
  var dataSource: CounterDataSource?
  func increment() {
    if let amount = dataSource?.increment?(forCount: count) {
      count += amount
    } else if let amount = dataSource?.fixedIncrement {
      count += amount
    }
  }
}

var counter = Counter()
counter.dataSource = ThreeSource()
counter.increment()
counter.count
/*:
 ## Requiring Dynamic Dispatch
 
 When Swift APIs are imported by the Objective-C runtime, there are no guarantees of dynamic dispatch for properties, methods, subscripts, or initializers. The Swift compiler may still devirtualize or inline member access to optimize the performance of your code, bypassing the Objective-C runtime.
 
 
 You can use the **dynamic** modifier to require that access to members be dynamically dispatched through the Objective-C runtime.
 */
class ClassWithRequiringDynamicDispatch: NSObject {
  @objc dynamic var variable: String = ""
  @objc dynamic func foo() { }
}
/*:
 ## Dynamic typing
 
 When you use AnyObject as a concrete type, you have at your disposal every @objc method and property that is, methods and properties imported from Objective-C or marked with the @objc attribute.
 
 These @objc symbols are available as implicitly unwrapped optional methods and properties, respectively.
 */
class IntegerRef {
  let value: Int
  
  init(_ value: Int) {
    self.value = value
  }
  
  @objc func getIntegerValue() -> Int {
    return value
  }
  
  @objc class func getDefaultValue() -> Int {
    return 42
  }
}

let obj: AnyObject = IntegerRef(100)

let possibleValue = obj.getIntegerValue?()
possibleValue

let certainValue = obj.getIntegerValue()
certainValue

if let f = obj.getIntegerValue {
  print("The value of 'obj' is \(f())")
} else {
  print("'obj' does not have a 'getIntegerValue()' method")
}

let someClass: AnyClass = IntegerRef.self
var defaultValue: Int? = someClass.getDefaultValue?()
defaultValue

/*:
 ## @objc
 
 @objc is inferred when:
 * The declaration is an override of an @objc declaration
 * The declaration satisfies a requirement in an @objc protocol
 * The declaration has one of the following attributes: @IBAction, @IBOutlet, @IBInspectable, @GKInspectable, or @NSManaged
 */

/*:
 ## @NSCopying
 
 This attribute causes the property’s setter to be synthesized with a copy of the property’s value.
 
 Apply this attribute to a stored variable property of a class. This attribute causes the property’s setter to be synthesized with a copy of the property’s value—returned by the copyWithZone(_:) method—instead of the value of the property itself. The type of the property must conform to the NSCopying protocol.
 
 */
class ClassWithObjectMyType {
  @NSCopying var objectMyType: MyType?
}

class MyType: NSObject, NSCopying {
  var value = 0
  
  init(value: Int) {
    self.value = value
  }
  
  public func copy(with zone: NSZone? = nil) -> Any {
    return MyType(value: value)
  }
}

do {
  let myType = MyType(value: 10)
  let instance = ClassWithObjectMyType()
  instance.objectMyType = myType
  instance.objectMyType?.value
  
  myType.value = 11
  instance.objectMyType?.value
}
