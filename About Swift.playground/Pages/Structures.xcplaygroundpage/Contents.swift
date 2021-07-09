//: [Previous](@previous)
//: # Structures
/*:
 - note:
 Structures are Value Types
 */
//: ## Structures With Default Values
struct Size {
  var width = 0.0, height = 0.0
}
/*:
 ### Initialization
 
 Swift provides a default initializer for any structure that provides default values for all of its properties and does not provide at least one initializer itself.
 */
let size0x0 = Size()
// Get Properties
size0x0.width
size0x0.height
/*:
 Structure types automatically receive a memberwise initializer if they do not define any of their own custom initializers.
 */
let size10x10 = Size(width: 10, height: 10)
size10x10.width
size10x10.height

var size10x0 = Size(width: 10)
size10x0.width
size10x0.height

// Set Properties
var size8x10 = size10x10
size8x10.width = 8

size8x10.width
size8x10.height
//: ## Structures Without Default values
struct Dog {
  var name: String
  var age: Int
  let gender: String
}
/*:
 ### Initialization
 
 Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that do not have default values.
 */
let aDog = Dog(name: "dogName", age: 5, gender: "male");
/*:
 ## Customizing Initialization
 
 An initializer cannot call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.
 */
struct Celsius {
  var temperatureInCelsius: Double
  
  init(fromFahrenheit fahrenheit: Double) {
    temperatureInCelsius = (fahrenheit - 32.0) / 1.8
  }
  
  init(fromKelvin kelvin: Double) {
    temperatureInCelsius = kelvin - 273.15
  }
  
  init(_ celsius: Double) {
    temperatureInCelsius = celsius
  }
}

Celsius(fromFahrenheit: 10)
Celsius(fromKelvin: 10)
Celsius(10)
/*:
 ## Initializer Delegation for Value Types
 
 Initializers can call other initializers to perform part of an instance’s initialization.
 
 For value types, you use self.init to refer to other initializers from the same value type when writing your own custom initializers. You can call self.init only from within an initializer.
 */
struct Point {
  var x = 0.0, y = 0.0
}

struct Rect {
  var origin = Point()
  var size = Size()
  
  // Calling this initializer returns a Rect instance whose origin and size
  // properties are both initialized with the default values of
  // Point(x: 0.0, y: 0.0) and Size(width: 0.0, height: 0.0).
  init() { }
  
  // This initializer simply assigns the origin and size argument values to the
  // appropriate stored properties.
  init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }
  
  // This initializer starts by calculating an appropriate origin point based on
  // a center point and a size value. It then calls (or delegates) to the
  // init(origin:size:) initializer, which stores the new origin and size values
  // in the appropriate properties.
  init(center: Point, size: Size) {
    let originX = center.x - (size.width / 2)
    let originY = center.y - (size.height / 2)
    
    // Initializer Delegation
    self.init(origin: Point(x: originX, y: originY), size: size)
  }
}

let aRect1 = Rect()

let aRect2 = Rect(center: Point(x: 1, y: 10),
                  size: Size(width: 100, height: 80))

let aRect3 = Rect(origin: Point(x: 100, y: 90),
                  size: Size(width: 90, height: 90))
/*:
 ## Failable Initializers
 
 You can define a failable initializer that creates an implicitly unwrapped optional instance of the appropriate type. Do this by placing an exclamation mark after the init keyword (init!) instead of a question mark.
 
 A failable initializer can delegate across to another failable initializer.
 */
struct StructureWithFailableInitializers {
  init?() {
    nil
  }
}

var aStructure = StructureWithFailableInitializers()
/*:
 ## Observers for Stored properties
 
 Like Observers for Stored Variables
 */
/*:
 ## Lazy Stored properties
 
 * Must be variables because constant properties must always have a value before initialization completes.
 */
/*:
 - important:
 If a lazy property has not yet been initialized and is accessed by more than one thread at the same time, there is no guarantee that the property will be initialized only once.
 */
struct StructureWithLazyStoredProperty {
  lazy var property = Size()
}

var aStructureWithLazyStoredProperty = StructureWithLazyStoredProperty()

aStructureWithLazyStoredProperty.property
// The instance of person has been created
/*:
 ## Computed Properties
 
 Like Computed Variables.
 
 Computed properties can't have Property Observers.
 */
//: ## Type Properties
struct StructureWithTypeProperties {
  static var typeProperty = 10
  
  static var computedTypeProperty: Int {
    typeProperty * 2
  }
}

StructureWithTypeProperties.typeProperty = 11
StructureWithTypeProperties.computedTypeProperty
//: ## Methods
struct StructureWithMethods {
  var storedProperty = 1
  
  //_____________________________________________
  // Instance methods
  
  func instanceMethod() {
    // Self type refers to the type introduced by the innermost type declaration
    Self.typeMethod()
  }
  
  // Mutating methods
  
  // Properties can be modified from within mutating methods.
  mutating func mutatingInstanceMethod2(_ value: Int) {
    self.storedProperty = value
  }
  
  // Mutating methods can assign an entirely new instance to the implicit
  // self property.
  mutating func mutatingInstanceMethod1() {
    self = StructureWithMethods()
  }
  
  //_____________________________________________
  // Type methods
  
  static func typeMethod() {
    
  }
}
/*:
 ## Subscripts
 
 Subscripts can:
 * use variable parameters.
 * use variadic parameters.
 * provide default parameter values.
 
 Subscripts cannot:
 * use in-out parameters.
 */
struct StructureWithSubscripts {
  //_____________________________________________
  // Instance Subscripts
  subscript(index: Int) -> Int {
    get {
      0
    }
    set {
      
    }
  }
  
  //read-only Subscripts.
  subscript(index: String) -> Int { 1 }
  
  //_____________________________________________
  // Type Subscripts
  static subscript(index: Int) -> Int {
    get { 0 }
    set { }
  }
}
/*:
 - example: A struct Matrix with subscript.
 */
struct Matrix {
  let rows: Int, columns: Int
  var grid: [Int]
  
  init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
    grid = Array(repeating: 0, count: rows * columns)
  }
  
  subscript(row: Int, column: Int) -> Int {
    get { grid[(row * columns) + column] }
    set { grid[(row * columns) + column] = newValue }
  }
  
  func printMatrix() {
    for i in 0..<rows {
      for j in 0..<columns {
        print(self[i, j], separator: "", terminator: "\t")
      }
      print("")
    }
  }
}

let value = 5
var identityMatrix = Matrix(rows: value, columns: value)
for i in 0..<value {
  identityMatrix[i, i] = 1
}
// identityMatrix.printMatrix()
/*:
 ## Callable values
 Values of types that declare func callAsFunction methods can be called like functions.
 */
struct Adder {
  
  var base: Int
  
  func callAsFunction(_ x: Int) -> Int {
    x + base
  }
  
}

var adder = Adder(base: 3)
adder(10)
adder.callAsFunction(10)
//: [Next](@next)
