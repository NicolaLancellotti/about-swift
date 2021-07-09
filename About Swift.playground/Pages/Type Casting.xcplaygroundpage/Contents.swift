//: [Previous](@previous)
//: # Type Casting
/*:
 ## Checking Type
 
 Use the type check operator (is) to check whether an instance is of a certain subclass type. The type check operator returns true if the instance is of that subclass type and false if it is not.
 */
class ClassA { }

class ClassB: ClassA { }

class ClassC: ClassB { }

let objectAnyObject: Any = ClassC()

objectAnyObject is ClassA
objectAnyObject is ClassB
objectAnyObject is ClassC
objectAnyObject is String
/*:
 ## Casting
 
 * Use the conditional form of the type cast operator (as?) when you are not sure if the downcast will succeed. This form of the operator will always return an optional value, and the value will be nil if the downcast was not possible. This enables you to check for a successful downcast.
 * Use the forced form of the type cast operator (as!) only when you are sure that the downcast will always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
 */
let objectClassA : ClassB = ClassC()

let o1 = objectClassA as ClassA     // Guaranteed conversion
let o2 = objectAnyObject as! ClassC // Forced conversion
let o3 = objectAnyObject as? String
/*:
 ## Function Casting
 The compiler strips argument labels from function references used with the as operator in a function call.
 */
func foo(x: Int) { }
func foo(x: UInt) { }

(foo as (Int) -> Void)(5)
(foo as (UInt) -> Void)(5)
/*:
 ## Type Casting for Any and AnyObject
 
 * AnyObject can represent an instance of any class type.
 * Any can represent an instance of any type at all, including function types.
 
 You can use the is and as operators in a switch statement’s cases to discover the specific type of a constant or variable that is known only to be of type Any or AnyObject.
 */
func f(_ any: Any) { print("Function for Any") }
func f(_ int: Int) { print("Function for Int") }
let x = 10
let y: Any = x
f(x) // prints "Function for Int"
f(y) // prints "Function for Any"
f(x as Any) // prints "Function for Any"

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append(-3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(ClassA())
things.append({ (name: String) -> String in "Hello, \(name)" })
//:The Any type represents values of any type, including optional types. Swift gives you a warning if you use an optional value where a value of type Any is expected.
let optionalNumber: Int? = 3
//things.append(optionalNumber)      // Warning
things.append(optionalNumber as Any) // No warning
/*:
 ### Switch
 
 In a switch statement, a value is cast to a type only when pattern matching with that type succeeds. For that reason, you use the as operator instead of the conditional as? or unconditional as! operators.
 */
for thing in things {
  switch thing {
    case 0 as Int:
      print("zero as an Int")
    case 0 as Double:
      print("zero as a Double")
    case let someInt as Int:
      print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
      print("a positive double value of \(someDouble)")
    case is Double:
      print("some other double value that I don't want to print")
    case let someString as String:
      print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
      print("an (x, y) point at \(x), \(y)")
    case let x as ClassA:
      print(x)
    case let stringConverter as (String) -> String:
      print(stringConverter("Michael"))
    default:
      print("something else")
  }
}
/*:
 - note:
 As a performance optimization, an unconditional downcast of a collection to a collection with a more specific type, such as NSArray as! [NSView], may defer type checking of each element until they are individually accessed. As a result, an unconditional downcast to an incompatible type may appear to succeed, until a type cast failure of an element triggers a runtime error.
 \
 \
 A conditional typecast of a collection to a collection with a more specific type, such as NSArray as? [NSView], will perform type checking of each element immediately, and return nil if a type cast failure occurs for any element.
 */
/*:
 ## Numeric Cast
 
 Typically used to do conversion to any contextually-deduced integer type.
 */
func f1(_ x: Int32) {
}

func g1(_ x: UInt64) {
  f1(numericCast(x))
}
/*:
 ## Unsafe Bit Cast
 
 Returns the bits of x, interpreted as having type U.
 */
struct A {
  var x = 10
}
struct B {
  var y: Int
}

let a: A = A()
let b = unsafeBitCast(a, to: B.self)
b.y
//: [Next](@next)
