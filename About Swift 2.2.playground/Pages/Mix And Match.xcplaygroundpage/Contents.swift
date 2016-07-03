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
    
    var property: String = ""
    
    func foo(_ value: Int){
        
    }
    
    @objc(fooWithStrig:)
    func foo(_ value: String){
        
    }
    
    @nonobjc
    func foo(_ value: Double){
        
    }
    
}
//: ## Selector Expression
extension SomeClass {
    func bar() {
        
    }
    
    func foobar(value: Int) {
        
    }
    
}

let selectorForPropertyGetter = #selector(getter: SomeClass.property)
let selectorForPropertySetter = #selector(setter: SomeClass.property)

let selectorForMethodBar = #selector(SomeClass.bar)
let selectorForMethodFoobar = #selector(SomeClass.foobar(value:))

let selectorForMethodFooString = #selector(SomeClass.foo(_:) as (SomeClass) -> (String) -> Void)
let selectorForMethodFooDouble = #selector(SomeClass.foo(_:) as (SomeClass) -> (Int) -> Void)

let x = SomeClass()
let selectorForMethodBar2 = #selector(x.bar)
let selectorForMethodFooString2 = #selector(x.foo(_:) as (String) -> Void)
/*:
 ## Optional Protocol Requirements
 
 When you use a method or property in an optional requirement, its type automatically becomes an optional. For example, a method of type (Int) -> String becomes ((Int) -> String)?.
 
 
 Optional protocol requirements can only be specified if your protocol is marked with the @objc attribute.
 Note also that @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.
 */
/*
@objc
protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

class Counter {
    
    var count = 0
    
    var dataSource: CounterDataSource?
    
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}
 */
//: [Next](@next)
