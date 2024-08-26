//: [Previous](@previous)
/*:
 # Tuples
 
 Tuples are useful for temporary groups of related values.
 */
/*:
 - note:
 Tuples are Value Types
 */
var yellowRGB = (red: 1, green: 1, blue: 0)
yellowRGB.red
yellowRGB.green
yellowRGB.blue

let whiteRGB = (1, 1, 1)
whiteRGB.0
whiteRGB.1
whiteRGB.2

let (red, _, blue) = yellowRGB
red
blue

let (a, _, (b, c)) = ("test", 9.45, (12, 3))
a
b
c

let point = (1, 1)
switch point {
  case (0, 0):
    print("(0, 0) is at the origin")
  case (_, 0):
    print("(\(point.0), 0) is on the x-axis")
  case (0, _):
    print("(0, \(point.1)) is on the y-axis")
  case (-2...2, -2...2):
    print("(\(point.0), \(point.1)) is inside the box")
  default:
    print("(\(point.0), \(point.1)) is outside of the box")
}
//: ### Value bindings
switch point {
  case (let x, 0):
    print("on the x-axis with an x value of \(x)")
  case (0, let y):
    print("on the y-axis with a y value of \(y)")
  case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
//: ## Tuple pattern
let points = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]

for (x, _) in points {
  x
}
/*:
 ## Comparison operators
 
 You can also compare tuples that have the same number of values, as long as
 each of the values in the tuple can be compared.
 
 Tuples are compared from left to right, one value at a time, until the
 comparison finds two values that aren’t equal. If all the elements are equal,
 then the tuples themselves are equal.
 
 The Swift standard library includes tuple comparison operators for tuples with
 less than seven elements. To compare tuples with seven or more elements, you
 must implement the comparison operators yourself.
 */
// true because 1 is less than 2
(1, "zebra") < (2, "apple")

// true because 3 is equal to 3, and "apple" is less than "bird"
(3, "apple") < (3, "bird")

// true because 4 is equal to 4, and "dog" is equal to "dog"
(4, "dog") == (4, "dog")
/*:
 ## Functions and tuples
 */
func function(_ tuple: (Int, Int)) -> (x: Int, y: Int) {
  (x: tuple.0, y: tuple.1)
}

function((1, 2))
//: [Next](@next)
