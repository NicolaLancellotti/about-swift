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

var point = CompassPoint.west
point = .east
/*:
 ## Initializers, computed properties, methods and subscripts
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

var onOffSwitch: OnOffSwitch = .on
onOffSwitch.toggle()

OnOffSwitch(symbol: "Z")
/*:
 ## Associated values
 
 Enumeration case values without associated values are hashable by default.
 */
enum Shape {
  case square(side: Double)
  case rectangle(base: Double, height: Double)
}

var shape = Shape.square(side: 10)
shape = .rectangle(base: 10, height: 11)
/*:
 Enumeration cases that store associated values can be used as functions that
 create instances of the enumeration with the specified associated values.
 */
let makeSquare = Shape.square
makeSquare(10)

let makeRectangle = Shape.rectangle
makeRectangle(10, 22)
/*:
 ## Raw values
 Raw values can be:
 * integers,
 * floating-points,
 * characters,
 * strings.
 
 Each raw value must be unique within its enumeration declaration.
 */
enum Planet: Int {
  // When integers are used for raw values, the implicit value for each case is
  // one more than the previous case. If the first case doesn’t have a value
  // set, its value is 0.
  case mercury = 1, venus, earth, mars, jupiter , saturn, uranus, neptune
}
Planet.earth.rawValue

enum Day: String {
  // When strings are used for raw values, the implicit value for each case is
  // the text of that case’s name.
  case sunday, monday, tuesday, wednesday, thursday, saturday
}
Day.sunday.rawValue
//: Enumerations with raw values automatically receive a failable initializer.
Planet(rawValue: 2)
/*:
 ## Recursive enumerations
 
 Instances of enumeration types have a fixed layout in memory. To support
 recursion, the compiler must insert a layer of indirection.
 
 To enable indirection for a particular enumeration case, mark it with the
 indirect declaration modifier.
 
 Write indirect before the beginning of the enumeration, to enable indirection
 for all of the enumeration’s cases.
 */
enum ArithmeticExpression {
  case number(Int)
  indirect case add(Self, Self)
  indirect case mul(Self, Self)
  
  func evaluate() -> Int {
    switch self {
      case let .number(value):
        return value
      case let .add(left, right):
        return left.evaluate() + right.evaluate()
      case let .mul(left, right):
        return left.evaluate() * right.evaluate()
    }
  }
}

let expr: ArithmeticExpression = .mul(.add(.number(5), .number(4)),
                                      .number(2))
expr.evaluate()

indirect enum ArithmeticExpression2 {
  case number(Int)
  case add(Self, Self)
  case mul(Self, Self)
}
//: ## Enumeration case pattern
//: ### Switch
switch shape {
  case let .rectangle(base, height):
    print("A rectangle with base: \(base) and height: \(height)")
  case .square(let side) where side == 10:
    print("A square with side == 10")
  default:
    print("A square with side != 10")
}

// Enumeration case pattern can match an optional value
let optionalPoint: CompassPoint? = .north
switch optionalPoint {
  case .north: print("north")
  case .south: print("south")
  case .east: print("east")
  case .west: print("west")
  case nil: print("nil")
}
//: ### If
if case .rectangle(let base, let height) = shape {
  print("A rectangle with base: \(base) and height: \(height)")
} else if case .square(let side) = shape, side == 10 {
  print("A square with side: 10")
} else if case .square(11) = shape {
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
