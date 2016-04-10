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


//: [Next](@next)
