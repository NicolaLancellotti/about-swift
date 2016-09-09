//: [Previous](@previous)
import Foundation
/*:
# Mix And Match

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
    
    var someProperty: String = "Hello"
    
    func foo(_ value: Int){
        
    }
    
    @objc(fooWithStrig:)
    func foo(_ value: String){
        
    }
    
    @nonobjc
    func foo(_ value: Double){
        
    }
    
}

let instance = SomeClass()
//: ## Selector Expression
extension SomeClass {
    func bar() {
        
    }
    
    func foobar(value: Int) {
        
    }
    
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
 ## Key-Path Expression
 
 A key-path expression lets you access the string used to refer to a property in Objective-C for use in key-value coding and key-value observing APIs.
 */
let keyPath = #keyPath(SomeClass.someProperty)
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
//: [Next](@next)
