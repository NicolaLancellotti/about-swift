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

let (redColor, _, blueColor) = yellowRGB
redColor
blueColor

let (a, _, (b, c)) = ("test", 9.45, (12, 3))
//: ## Switch
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}
//: ### Value Bindings
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
//: # Tuple Pattern
let points = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]

for (x, _) in points {
    x
}
/*:
 # Comparison Operators
 
 You can also compare tuples that have the same number of values, as long as each of the values in the tuple can be compared.
 
 Tuples are compared from left to right, one value at a time, until the comparison finds two values that aren’t equal. If all the elements are equal, then the tuples themselves are equal.
 
 The Swift standard library includes tuple comparison operators for tuples with less than seven elements. To compare tuples with seven or more elements, you must implement the comparison operators yourself.
 
 */

(1, "zebra") < (2, "apple")   // true because 1 is less than 2
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"


/*:
 ## Functions can Return a Tuple.
 */
func funcReturnTuple() -> (par1: Bool, par2: Bool) {
    return (true, false)
}

let value = funcReturnTuple()
value.par1
value.par2

//: [Next](@next)
