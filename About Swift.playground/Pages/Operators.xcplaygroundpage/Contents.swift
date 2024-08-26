//: [Previous](@previous)
//: # Operators
//: ## Ternary conditional operator
let value = true ? 1 : 2
/*:
 ## Operators overload
 
 It is not possible to overload the default assignment operator (`=`). Only the
 compound assignment operators can be overloaded. Similarly, the ternary
 conditional operator (`a ? b : c`) cannot be overloaded.
 */
struct Vector2D {
  var x = 0.0, y = 0.0
}

extension Vector2D {
  static func + (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
    Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }
  
  static func += (lhs: inout Vector2D, rhs: Vector2D) {
    lhs = lhs + rhs
  }
}

var vector1 = Vector2D(x: 1, y: 2) + Vector2D(x: 2, y: 4)
vector1.x
vector1.y

vector1 += Vector2D(x: 1, y: 1)
vector1.x
vector1.y
//: ### Pattern matching
func ~=(pattern: String, value: Int) -> Bool {
  pattern == "\(value)"
}

"1" ~= 1

let point = (1, 2)
switch point {
case ("0", "0"): "(0, 0) is at the origin."
default: "The point is at (\(point.0), \(point.1))."
}
/*:
 ### Prefix and postfix operators
 */
extension Vector2D {
  
  static prefix func - (vector: Vector2D) -> Vector2D {
    Vector2D(x: -vector.x, y: -vector.y)
  }
  
  static prefix func ++ (vector: inout Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
  }
  
  static postfix func ++ (vector: inout Vector2D) -> Vector2D {
    let tmp = vector
    vector += Vector2D(x: 1.0, y: 1.0)
    return tmp
  }
}

var vector2 = Vector2D(x: 1, y: 1)
vector2++
vector2
/*:
 ## Custom operators
 
 New operators are declared at a global level using the operator keyword, and
 are marked with the `prefix`, `infix` or `postfix` modifiers.
 */
prefix operator +++

extension Vector2D {
  // It doubles the x and y values of a Vector2D instance
  static prefix func +++ (vector: inout Vector2D) -> Vector2D {
    vector += vector
    return vector
  }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
afterDoubling.x
afterDoubling.y
/*: 
 ### Precedence for custom infix operators
 
 Custom infix operators each belong to a precedence group. A precedence group
 specifies an operator’s precedence relative to other infix operators, as well
 as the operator’s associativity.
 */
infix operator +-: AdditionPrecedence
extension Vector2D {
  static func +- (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
    Vector2D(x: lhs.x + rhs.x, y: lhs.y - rhs.y)
  }
}

let vector3 = Vector2D(x: 1.0, y: 2.0) +- Vector2D(x: 3.0, y: 4.0)
vector3.x
vector3.y
/*:
 - note:
 You do not specify a precedence when defining a prefix or postfix operator.
 However, if you apply both a prefix and a postfix operator to the same operand,
 the postfix operator is applied first.
 */
/*:
 ## Callable values
 Values of types that declare func callAsFunction methods can be called like
 functions.
 */
struct Adder {
  
  let base: Int
  
  func callAsFunction(_ x: Int) -> Int {
    x + base
  }
  
}

var adder = Adder(base: 3)
adder(10)
adder.callAsFunction(10)
//: [Next](@next)
