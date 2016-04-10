//: [Previous](@previous)

//: # Miscellaneous

//: ## Type Alias Declaration

typealias Length = Double
let length: Length = 0.0

//: ## Multiple separate statements on a single line
let cat = "?"; print(cat)

/*:
 ## @warn_unused_result
 
 Apply this attribute to a method or function declaration to have the compiler emit a warning when the method or function is called without using its result.
 */

struct Increaser {
    var value = 0
    
    //    @warn_unused_result(message="my message")
    @warn_unused_result(mutable_variant="increaseInPlace")
    func increase() -> Int {
        return value + 1
    }
    
    mutating func increaseInPlace() {
        value += 1
    }
}

/*:
 ## One-Time Initialization
 
 In Swift, global constants and stored type properties are guaranteed to be initialized only once, even when accessed across multiple threads simultaneously.
 */


/*:
 ## Optionals
 An optional is an enumeration with two associated Values:
 * case None
 * case Some(type)
 
 */
//let someOptional: Optional<Int> = 42
let someOptional: Int? = 42
let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]

//: Enumeration Case Pattern
if case .Some(let x)  = someOptional {
    //   print("x: \(x)")
}

for case .Some(let number) in arrayOfOptionalInts {
    //    print("\(number)")
}

//: Optional Pattern
if case let x? = someOptional {
    //        print("x: \(x)")
}

for case let number? in arrayOfOptionalInts {
    //        print("\(number)")
}

//: [Next](@next)
