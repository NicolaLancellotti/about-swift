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
class AClass : NSObject {
    
    func foo(value: Int){
        
    }
    
    @objc(fooWithStrig:)
    func foo(value: String){
        
    }
    
    @nonobjc
    func foo(value: Double){
        
    }
    
    func bar() {
        print("ciao")
    }
    
}
//: ## Selector Expression
let x = AClass()
let aSelector = #selector(x.foo(_:) as (String) -> Void)
let anotherSelector = #selector(x.bar)
/*:
 ## Optional Protocol Requirements
 
 When you use a method or property in an optional requirement, its type automatically becomes an optional. For example, a method of type (Int) -> String becomes ((Int) -> String)?.
 
 
 Optional protocol requirements can only be specified if your protocol is marked with the @objc attribute.
 Note also that @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.
 */
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
//: [Next](@next)
