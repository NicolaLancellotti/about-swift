//: [Previous](@previous)
//: # Classes
/*:
 - note:
 Classes are Reference Types
 */
//: ## Inheritance
class Superclass {
  //_____________________________________________
  // Instance Properties
  
  var storedProperty = ""
  
  var computedProperty: String { "Superclass" }
  
  //_____________________________________________
  // Instance Subscripts
  
  subscript(index: Int) -> Int {
    get { 0 }
    set { }
  }
  
  //_____________________________________________
  // Instance Methods
  func instanceMethod() { }
  
  //_____________________________________________
  // Type Computed Properties
  class var typeComputedProperty: Int {
    get { 0 }
    set { }
  }
  
  //_____________________________________________
  // Type Subscripts
  class subscript(index: Int) -> Int {
    get { 0 }
    set { }
  }
  
  //_____________________________________________
  // Type Methods
  class func typeClassMethod() { }
}

class Subclass: Superclass {
  // You must always state both the name and the type of the property you are
  // overriding.
  
  //_____________________________________________
  // Overriding Property Getters and Setters
  //
  // You can present an inherited read-only property as a read-write property by
  // providing both a getter and a setter but not the other way around.
  override var computedProperty: String {
    super.computedProperty + "- Subclass"
  }
  
  //_____________________________________________
  // Overriding Property Observers
  // Property observers can be added to any property
  // (stored or computed property).
  
  // When you assign a default value to a stored property, or set its initial
  // value within an initializer, the value of that property is set directly,
  // without calling any property observers.
  
  // The willSet and didSet observers of superclass properties are called when a
  // property is set in a subclass initializer.
  
  // You cannot add property observers to inherited constant stored properties
  // or inherited read-only computed properties.
  override var storedProperty: String {
    didSet { }
  }
  
  //_____________________________________________
  // Overriding Methods
  override func instanceMethod() {
    print("Subclass - instanceMethod")
  }
}
/*:
 - note:
 You cannot provide both an overriding setter and an overriding property
 observer for the same property.
 \
 \
 If you want to observe changes to a property’s value, and you are already
 providing a custom setter for that property, you can simply observe any value
 changes from within the custom setter.
 */
/*: 
 ## Preventing overrides
 
 You can mark an entire class as final by writing the final modifier before the
 class keyword in its class definition (`final class`).
 */
class ClassWithMethodsAndPropertiesFinal {
  //_____________________________________________
  // Instance Properties
  final var storedProperty = ""
  final var computedProperty: Int {
    get { 0 }
    set { }
  }
  
  //_____________________________________________
  // Instance Subscripts
  final subscript(index: Int) -> Int {
    get { 0 }
    set { }
  }
  
  //_____________________________________________
  // Instance Methods
  final func instanceMethod() { }
  
  //_____________________________________________
  // Type Properties
  static let typeStoredProperty = 0
  
  static var typeComputedProperty: Int {
    get { 0 }
    set { }
  }
  
  //_____________________________________________
  // Type Subscripts
  static subscript(index: Int) -> Int {
    get { 0 }
    set { }
  }
  
  //_____________________________________________
  // Type Methods
  static func typeClassMethod() { }
}
/*:
 ## Initialization
 
 Class instances do not receive a default memberwise initialize.
 
 ### Designated initializers
 
 Every class must have at least one designated initializer.
 1. It fully initializes all properties.
 2. It delegates up to a superclass initializer.
 3. It assigns a value to an inherited property.
 
 ### Convenience initializers
 
 Convenience initializers are secondary, supporting initializers for a class.
 
 A Convenience initializer is written with the convenience modifier placed
 before the init keyword.
 1. It delegates across to another initializer.
 2. It assigns a value to any property (including properties defined by the same
 class).
 */
class SuperclassInitializers {
  var propertySuperclass: Int = 0
}

class SubclassInitializers: SuperclassInitializers {
  var propertySubclass1: Int
  var propertySubclass2: Int
  
  //_____________________________________________
  // Designated Initializers
  init(propertySubclass1: Int, propertySubclass2: Int) {
    // Fully initializes all properties.
    self.propertySubclass1 = propertySubclass1
    self.propertySubclass2 = propertySubclass2
    
    // Delegates up to a superclass initializer.
    super.init()
    
    // Assigning a value to an inherited property.
    propertySuperclass = 1
  }
  
  override init() {
    // Fully initializes all properties.
    self.propertySubclass1 = 1
    self.propertySubclass2 = 2
    
    // Delegates up to a superclass initializer.
    super.init()
  }
  
  //_____________________________________________
  // Convenience Initializers
  convenience init(propertySubclass1: Int) {
    // Delegate across to another initializer.
    self.init()
    
    // Assigning a value to any property (including properties defined by the
    // same class).
    self.propertySubclass1 = propertySubclass1
  }
  
}
/*:
 ### Automatic initializer inheritance
 Swift subclasses do not inherit their superclass initializers by default.
 
 Assuming that you provide default values for any new properties you introduce
 in a subclass.
 
 * If your subclass doesn’t define any designated initializers.
 It automatically inherits all of its superclass designated initializers.
 
 * If your subclass provides an implementation of all of its superclass
 designated initializers
 then it automatically inherits all of the superclass convenience initializers.
 */
/*:
 ### Failable initializer
 You can override a failable initializer with a nonfailable initializer but not
 the other way around.
 
 Initialization failure propagates through initializer delegation. Specifically,
 if a failable initializer delegates to an initializer that fails and returns
 nil, then the initializer that delegated also fails and implicitly returns nil.
 */
class ClassWithFailableInitializer {
  var property: Int
  
  // Failable initializer
  init?(property: Int) {
    if property < 0 {
      return nil
    }
    self.property = property
  }
  
  init() {
    self.property = 0;
  }
}

class SubclassWithFailableInitializer: ClassWithFailableInitializer {
  
  // Override a failable initializer with a nonfailable initializer
  override init(property: Int) {
    super.init()
    if property < 0 {
      self.property = 0
    }
  }
  
}
//: ### Required initializers
class ClassWithRequiredInitializer {
  // Every subclass of the class must implement this initializer
  required init() { }
}

class SubclassWithRequiredInitializer: ClassWithRequiredInitializer {
  // You must also write the required modifier before every subclass
  // implementation of a required initializer
  // You do not write the override modifier when overriding a required
  // designated initializer
  required init() { }
}
/*:
 ## Deinitialization
 
 * The superclass deinitializer is called automatically at the end of a
 subclass deinitializer implementation.
 * Superclass deinitializers are always called, even if a subclass does not
 provide its own deinitializer.
 * The subclass object is not deallocated until all deinitializers in its
 inheritance chain have finished executing.
 */
class ClassWithDeinit {
  deinit { }
}
/*:
 ## Automatic reference counting
 
 * Weak references must be declared as variables, to indicate that their value
 can change at runtime.
 * If you try to access an unowned reference after the instance that it
 references is deallocated, you will trigger a runtime error.
 */
/*:
 - note: See ARC.pdf in Resources
 */
//: ### Lifetime
do {
  class ClassB {
    let value = 10
  }
  
  class ClassA {
    weak var weakInstance: ClassB?
    var value: Int { weakInstance!.value }
  }
  
  let value = ClassB()
  let instance = ClassA()
  instance.weakInstance = value
  
  do {
    withExtendedLifetime(value) {
      assert(instance.value == 10)
    }
  }
  
  do {
    assert(instance.value == 10)
    withExtendedLifetime(value) { }
  }
  
  do {
    defer {withExtendedLifetime(value){ }}
    instance.weakInstance = value
    assert(instance.value == 10)
  }
  
//   assert(instance.value == 10) // Error
}
/*:
 ## Identity operators
 
 * Identical to ===
 * Not identical to !==
 */
class ClassIdentityOperators { }

let object1A = ClassIdentityOperators()
let object2 = ClassIdentityOperators()
let object1B = object1A

object1A === object2
object1A === object1B
//: [Next](@next)
