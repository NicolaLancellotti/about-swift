//: [Previous](@previous)
//: # Structures
/*:
 - note:
 Structures are Value Types
 */
//: ## Structures with default values
struct Size {
  var width = 0.0, height = 0.0
}
/*:
 ### Initialization
 
 Swift provides a default initializer for any structure that provides default
 values for all of its properties and does not provide at least one initializer
 itself.
 */
let size0x0 = Size()
size0x0.width
size0x0.height
/*:
 Structure types automatically receive a memberwise initializer if they do not
 define any of their own custom initializers.
 */
let size10x10 = Size(width: 10, height: 10)
size10x10.width
size10x10.height

var size10x0 = Size(width: 10)
size10x0.width
size10x0.height

var size8x10 = size10x10
size8x10.width = 8

size8x10.width
size8x10.height
//: ## Structures without default values
struct Dog {
  var name: String
  var age: Int
}
/*:
 ### Initialization
 
 Unlike a default initializer, the structure receives a memberwise initializer
 even if it has stored properties that do not have default values.
 */
let dog = Dog(name: "dogName", age: 5);
/*:
 ## Customizing initialization
 
 An initializer cannot call any instance methods, read the values of any
 instance properties, or refer to self as a value until after the first phase of
 initialization is complete.
 */
struct Temperature {
  var celsius: Double
  
  init(fahrenheit: Double) {
    self.celsius = (fahrenheit - 32.0) / 1.8
  }
  
  init(kelvin: Double) {
    self.celsius = kelvin - 273.15
  }
  
  init(celsius: Double) {
    self.celsius = celsius
  }
}

Temperature(fahrenheit: 10)
Temperature(kelvin: 10)
Temperature(celsius: 10)
/*:
 ## Initializer delegation for value types
 
 Initializers can call other initializers to perform part of an instance’s
 initialization.
 
 For value types, you use `self.init` to refer to other initializers from the
 same value type when writing your own custom initializers. You can call
 `self.init` only from within an initializer.
 */
struct Point {
  var x = 0.0, y = 0.0
}

struct Rectangle {
  var origin = Point()
  var size = Size()
  
  // Calling this initializer returns a Rectangle instance whose origin and size
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

let rectangle1 = Rectangle()

let rectangle2 = Rectangle(center: Point(x: 1, y: 10),
                           size: Size(width: 100, height: 80))

let rectangle3 = Rectangle(origin: Point(x: 100, y: 90),
                           size: Size(width: 90, height: 90))
/*:
 ## Failable initializers
 */
struct StructureWithFailableInitializers {
  init?(value: Bool) {
    nil
  }
  init!(value: Int) {
    nil
  }
}

StructureWithFailableInitializers(value: true)
StructureWithFailableInitializers(value: 1)
/*:
 ## Observers for stored properties
 
 Like Observers for Stored Properties
 */
/*:
 ## Lazy stored properties
 
 * Lazy Stored Properties must be variables because constant properties must
 always have a value before initialization completes.
 */
/*:
 - important:
 If a lazy property has not yet been initialized and is accessed by more than
 one thread at the same time, there is no guarantee that the property will be
 initialized only once.
 */
struct StructureWithLazyStoredProperty {
  lazy var property = Size()
}

var value = StructureWithLazyStoredProperty()
value.property
/*:
 ## Computed properties
 
 Like Computed Variables.
 
 Computed properties can't have Property Observers.
 */
//: ## Type properties
struct StructureWithTypeProperties {
  static let typeProperty = 10
  
  static var computedTypeProperty: Int {
    typeProperty * 2
  }
}

StructureWithTypeProperties.typeProperty
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
  mutating func mutatingInstanceMethod1(_ value: Int) {
    self.storedProperty = value
  }
  
  // Mutating methods can assign an entirely new instance to the implicit
  // self property.
  mutating func mutatingInstanceMethod2() {
    self = StructureWithMethods()
  }
  
  //_____________________________________________
  // Type methods
  
  static func typeMethod() {
    
  }
}
//: ## Init accessors
struct StructureWithInitAccessor  {
  var x: Int
  
  var y: Int

  var z: Int {
    @storageRestrictions(initializes: y, accesses: x)
    init(newValue) {
      y = newValue + x
    }

    get { y }
    set { y = newValue }
  }
}

let value1 = StructureWithInitAccessor(x: 1, z: 2)
value1.x
value1.y
value1.z
/*:
 ## Subscripts
 
 Subscripts can:
 * use variable parameters,
 * use variadic parameters,
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

do {
  let value = 5
  var identityMatrix = Matrix(rows: value, columns: value)
  for i in 0..<value {
    identityMatrix[i, i] = 1
  }
  identityMatrix.printMatrix()
}
/*:
 ## Distinguish between methods or initializers whose names differ only by the names of their arguments
 */
struct StructWithMethods {
  func method1(_ x: Int, y: Int) { }
  func method1(_ x: Int, z: Int) { }
  func method2(_ x: Int, y: Int) { }
  func method2(_ x: Int, y: Bool) { }
}

let instance = StructWithMethods()

// let f1 = instance.method1    // Ambiguous
let f2 = instance.method1(_:y:) // Unambiguous

// let f3 = instance.method2        // Ambiguous
// let f4 = instance.method2(_:y:)  // Still ambiguous
let f4: (Int, Bool) -> Void  = instance.method2(_:y:)  // Unambiguous
//: [Next](@next)
