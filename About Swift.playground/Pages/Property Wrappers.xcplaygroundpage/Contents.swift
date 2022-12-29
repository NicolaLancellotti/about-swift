//: [Previous](@previous)
/*:
 # Property Wrappers
 
 A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property.
 
 When you apply a wrapper to a property, the compiler synthesizes code that provides storage for the wrapper and code that provides access to the property through the wrapper.
 
 A property wrapper can expose additional functionality by defining a projected value.
 
 The name of the projected value is the same as the wrapped value, except it begins with a dollar sign ($).
 
 */
@propertyWrapper
public struct SmallNumber {
  // ________________________________________________
  // Instance properties
  public var maximum: Int
  
  private var number: Int {
    didSet {
      projectedValue = number > maximum
      number = min(number, maximum)
    }
  }
  
  // ________________________________________________
  // PropertyWrapper properties
  public var wrappedValue: Int {
    get { number }
    set { number = newValue }
  }
  
  // Keep track of whether the property wrapper adjusted the
  // new value for the property before storing that new value
  public var projectedValue: Bool = false
  
  // ________________________________________________
  // Initialisers
  public init() {
    self.init(wrappedValue: 0)
  }
  
  public init(wrappedValue: Int) {
    self.init(wrappedValue: wrappedValue, maximum: 100)
  }
  
  public init(wrappedValue: Int, maximum: Int) {
    self.maximum = maximum
    self.number = wrappedValue
    projectedValue = wrappedValue > maximum
    self.number = min(wrappedValue, maximum)
  }
}

struct Values {
  // It calls SmallNumber.init(wrappedValue: 1, maximum: 5)
  @SmallNumber(wrappedValue: 1, maximum: 5) var x1: Int
  @SmallNumber(maximum: 5) var x2: Int = 1
  
  // It calls SmallNumber.init(wrappedValue: 101)
  @SmallNumber var x3: Int = 101
  
  // It calls SmallNumber.init()
  @SmallNumber var x4: Int
  
  var maximumForX1: Int {
    // _x1 is the property wrapper instance
    // x1 refers to _x1.wrappedValue
    // $x1 refers to _x1.projectedValue
    let smallNumber: SmallNumber = _x1
    return smallNumber.maximum
  }
  
  // Each propery wrapper translates to:
  private var _x5 = SmallNumber()
  var x5: Int {
    get { _x5.wrappedValue }
    set { _x5.wrappedValue = newValue }
  }
  
  var dollarx5: Bool {
    get { _x5.projectedValue }
    set { _x5.projectedValue = newValue }
  }
}

var values = Values()

values.maximumForX1

values.x1 = 10 // maximum: 5
values.$x1     // true because 10 > maximum

values.x1 = 5 // maximum: 5
values.$x1    // false because 5 <= maximum
/*:
 ## Property wrappers on function parameters
 */
/*:
 ### Implementation-detail property wrappers
 By default, property wrappers are implementation detail.
 */
func foo(@SmallNumber(maximum: 5) value: Int) {
  let backingStorage: SmallNumber = _value
  let wrappedValue: Int = value // of the innermost property wrapper
  let projectedValue: Bool = $value // of outermost property wrapper
  
  let _ = (backingStorage, wrappedValue, projectedValue)
}

foo(value: 6)
/*:
 ### API-level property wrappers
 Property wrappers that declare an init(projectedValue:) initializer are inferred to be API-level wrappers. These
 wrappers become part of the function signature, and the property wrapper is initialized at the call-site of the function.
 */
@propertyWrapper
struct APILevelPropertyWrapper {
  var wrappedValue: Int
  var projectedValue: Self { self }
  
  init(wrappedValue: Int) {
    self.wrappedValue = wrappedValue
  }
  
  init(projectedValue: Self) {
    self = projectedValue
  }
}

func bar(@APILevelPropertyWrapper value: Int) {
/*:
 The compiler generates:
 
 `func bar(value _value: APILevelPropertyWrapper)`
 */
  let wrappedValue = value // of the innermost property wrapper
  let projectedValue = $value // of outermost property wrapper
  
  let _ = (wrappedValue, projectedValue)
}

bar(value: 10) // init(wrappedValue:)
bar($value: APILevelPropertyWrapper(wrappedValue: 10)) // init(projectedValue:)
//: Unapplied function references
let _: (Int) -> () = bar
let _: (APILevelPropertyWrapper) -> () = bar($value:)
/*:
 ## Property wrappers on closure parameters
 */
//: ### Pass a wrapped value
let _: (Int) -> Void = { (@APILevelPropertyWrapper value) in
}
//: ### Pass a projected value
let _: (APILevelPropertyWrapper) -> Void = { (@APILevelPropertyWrapper $value) in
}
//: The property-wrapper attribute is not necessary if the backing property wrapper and the projected value have the same type
let _: (APILevelPropertyWrapper) -> Void = { $value in
}
//: [Next](@next)
