//: [Previous](@previous)

//: # Enumeration

//: Enumeration case values without associated values are hashable by default.

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

enum OnOffSwitch {
    case on, off
    
    mutating func toggle() {
        switch self {
        case off:
            self = on
        case on:
            self = off
        }
    }
}


enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}


/*:
 ## Associated Values
 Like tagged unions.
 */


enum Shape {
    case square(side: Double)
    case rectangle(base: Double, height: Double)
}

var aShape = Shape.square(side: 10)
aShape = .rectangle(base: 10, height: 11)

switch aShape {
case let .rectangle(base, height):
    break
case .square(let side):
    break
}

//: Enumeration cases that store associated values can be used as functions that create instances of the enumeration with the specified associated values.
let makeSquare = Shape.square
makeSquare(side: 10)
let makeRectangle = Shape.rectangle
makeRectangle(base: 10, height: 22)

/*:
 ## Raw Values
 Raw values can be:
 * Integer.
 * Floating-point.
 * Strings.
 * Characters.
 
 Each raw value must be unique within its enumeration declaration.
 */

enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

/*:
 ### Implicitly Assigned Raw Values
 When strings are used for raw values, the implicit value for each case is the text of that case’s name.
 */


enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter , saturn, uranus, neptune
}


/*:
 ### Initializing from a Raw Value
 Enumerations with raw values automatically receive a failable initializer.
 */
let aPlanet = Planet(rawValue: 2)


/*:
 ## Recursive Enumerations
 
 instances of enumeration types have value semantics, which means they have a fixed layout in memory. To support recursion, the compiler must insert a layer of indirection.
 
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
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))

/*:
 ## Computed properties and Methods
 Like structures.
 */

//: ## Enumeration Case Pattern

if case .square(let side) = aShape where side == 10 {
}


let enumValues: [Shape] = [.square(side: 10), .square(side: 10), .rectangle(base: 10, height: 11)]
for case .square(let value) in enumValues where value == 10 {
    
}

//: [Next](@next)
