//: [Previous](@previous)

//: # Enumeration

//: Enumeration case values without associated values are hashable by default.

enum CompassPoint {
    case North
    case South
    case East, West
}

var aCompassPoint = CompassPoint.West
aCompassPoint = .East

enum OnOffSwitch {
    case On, Off
    
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}


enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
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
    case Mercury = 1, Venus, Earth, Mars, Jupiter , Saturn, Uranus, Neptune
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
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression2 {
    case Number(Int)
    case Addition(ArithmeticExpression2, ArithmeticExpression2)
    case Multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

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
