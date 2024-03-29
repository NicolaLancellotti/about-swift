//: [Previous](@previous)
//: # Enumeration
/*:
 - note:
 Enumeration are Value Types
 */
enum CompassPoint {
  case north
  case south
  case east, west
}

var aCompassPoint = CompassPoint.west
aCompassPoint = .east
/*:
 ## Initializers, Computed Properties, Methods and Subscripts
 Like structures.
 */
enum OnOffSwitch {
  case on, off

  init?(symbol: String) {
    switch symbol {
      case "on":
        self = .on
      case "off":
        self = .off
      default:
        return nil
    }
  }
  
  mutating func toggle() {
    switch self {
      case .off:
        self = .on
      case .on:
        self = .off
    }
  }
}

var anOnOffSwitch: OnOffSwitch = .on
anOnOffSwitch.toggle()

let anotherOnOffSwitch = OnOffSwitch(symbol: "Z")
/*:
 ## Associated Values
 
 Enumeration case values without associated values are hashable by default.
 */
enum Shape {
  case square(side: Double)
  case rectangle(base: Double, height: Double)
}

var aShape = Shape.square(side: 10)
aShape = .rectangle(base: 10, height: 11)
//: Enumeration cases that store associated values can be used as functions that create instances of the enumeration with the specified associated values.
let makeSquare = Shape.square
makeSquare(10)

let makeRectangle = Shape.rectangle
makeRectangle(10, 22)
/*:
 ## Raw Values
 Raw values can be:
 * Integer.
 * Floating-point.
 * Characters.
 * Strings.
 
 Each raw value must be unique within its enumeration declaration.
 */
enum Planet: Int {
  // When integers are used for raw values, the implicit value for each case is
  // one more than the previous case. If the first case doesn’t have a value
  // set, its value is 0.
  case mercury = 1, venus, earth, mars, jupiter , saturn, uranus, neptune
}

let aPlanet = Planet.earth
aPlanet.rawValue

enum ASCIIControlCharacter: Character {
  case tab = "\t"
  case lineFeed = "\n"
  case carriageReturn = "\r"
}

enum Day: String {
  // When strings are used for raw values, the implicit value for each case is
  // the text of that case’s name.
  case sunday, monday, tuesday, wednesday, thursday, saturday
}

let aDay = Day.sunday
aDay.rawValue
//: Enumerations with raw values automatically receive a failable initializer.
let anotherPlanet = Planet(rawValue: 2)
/*:
 ## Recursive Enumerations
 
 Instances of enumeration types have value semantics, which means they have a fixed layout in memory. To support recursion, the compiler must insert a layer of indirection.
 
 To enable indirection for a particular enumeration case, mark it with the indirect declaration modifier.
 
 Write indirect before the beginning of the enumeration, to enable indirection for all of the enumeration’s cases.
 */
enum ArithmeticExpression {
  case number(Int)
  indirect case addition(ArithmeticExpression, ArithmeticExpression)
  indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression2 {
  case number(Int)
  case addition(ArithmeticExpression2, ArithmeticExpression2)
  case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum,
                                                  ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
  switch expression {
    case let .number(value):
      return value
    case let .addition(left, right):
      return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
      return evaluate(left) * evaluate(right)
  }
}

evaluate(product)
//: ## Enumeration Case Pattern
//: ### Switch
var anotherShape: Shape
anotherShape = .rectangle(base: 10, height: 100)
//anotherShape = .square(side: 10)
//anotherShape = .square(side: 11)

switch anotherShape {
  case let .rectangle(base, height):
    print("A rectangle with base: \(base) and height: \(height)")
  case .square(let side) where side == 10:
    print("A square with side: 10")
  default:
    print("A square with side != 10")
}
// Enumeration case pattern can match an optional value
let x: CompassPoint? = .north

switch x {
  case .north: print("north")
  case .south: print("south")
  case .east: print("east")
  case .west: print("west")
  case nil: print("nil")
}
//: ### If
if case .rectangle(let base, let height) = anotherShape {
  print("A rectangle with base: \(base) and height: \(height)")
} else if case .square(let side) = anotherShape, side == 10 {
  print("A square with side: 10")
} else if case .square(11) = anotherShape {
  print("A square with side: 11")
}
//: ### For
let enumValues: [Shape] = [
  .square(side: 10),
  .square(side: 20),
  .rectangle(base: 10, height: 11)
]

for case .square(let side) in enumValues where side > 10 {
  print("A square with side: \(side)")
}
//: ## CaseIterable
enum CompassDirection: CaseIterable {
  case north, south, east, west
}
CompassDirection.allCases
//: [Next](@next)
