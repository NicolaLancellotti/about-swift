//: [Previous](@previous)

/*:
 # Optional Chaining
 
 Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil.
 
 The result of an optional chaining call is of the same type as the expected return value, but wrapped in an optional.
 
 You specify optional chaining by placing a question mark (?) after the optional value on which you wish to call a property, method or subscript if the optional is non-nil
 
 */


class Person {
    var name = ""
    
    var children = [Person]()
    
    subscript(i: Int) -> Person {
        get {
            return children[i]
        }
        set {
            children[i] = newValue
        }
    }
    
    func printName() {
        print("The ownner's name is \(name)")
    }
    
    func funcReturnInt() -> Int {
        return 42
    }
    
}


var person: Person?
//: ## Accessing Properties Through Optional Chaining
let name = person?.name
//: Any attempt to set a property through optional chaining returns a value of type Void?
//person = Person()

person?.name = "Nicola"


if (person?.name = "Nicola") != nil {
    true
} else {
    false
}

/*:
 ## Calling Methods Through Optional Chaining
 
 Functions and methods with no return type have an implicit return type of Void.
 */
//person = Person()

let value = person?.funcReturnInt()
person?.printName()

if person?.printName() != nil {
    true
} else {
    false
}

//: ## Accessing Subscripts Through Optional Chaining
//person = Person()
//person?.children.append(Person())

let firstChilName = person?[0].name
person?[0].name = "Ilenia"

if (person?[0].name = "Ilenia") != nil {
    true
} else {
    false
}


/*:
 ## Linking Multiple Levels of Chaining
 
 You can link together multiple levels of optional chaining to drill down to properties, methods, and subscripts deeper within a model. However, multiple levels of optional chaining do not add more levels of optionality to the returned value.
 
 * If the type you are trying to retrieve is not optional, it will become optional because of the optional chaining.
 * If the type you are trying to retrieve is already optional, it will not become more optional because of the chaining.
 */

//: [Next](@next)
