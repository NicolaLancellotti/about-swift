/*:
 # Property Wrappers
 A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property
 
 When you apply a wrapper to a property, the compiler synthesizes code that provides storage for the wrapper and code that provides access to the property through the wrapper
 
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
    get { return number }
    set { number = newValue }
  }
  
  //  keep track of whether the property wrapper adjusted the
  //  new value for the property before storing that new value
  public var projectedValue: Bool = false
  

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
  
  // call SmallNumber.init(wrappedValue: 1, maximum: 5)
  @SmallNumber(wrappedValue: 1, maximum: 5) var x1: Int
  @SmallNumber(maximum: 5) var x2: Int = 1
  
  // call SmallNumber.init(wrappedValue: 101)
  @SmallNumber var x3: Int = 101
  
  // call SmallNumber.init()
  @SmallNumber var x4: Int
  
  var maximumForX1: Int {
    // _x1 is the property wrapper instance
    // x1 refers to _x1.wrappedValue
    // $x1 refers to _x1.projectedValue
    let smallNumber: SmallNumber = _x1
    return smallNumber.maximum
  }
  
  // each propery wrapper translates to:
  private var _x5 = SmallNumber()
  var x5: Int {
    get { return _x5.wrappedValue }
    set { _x5.wrappedValue = newValue }
  }

  var dollarx5: Bool {
    get { return _x5.projectedValue }
    set { _x5.projectedValue = newValue }
  }
  
}

var values = Values()

values.maximumForX1

values.x1 = 10 // maximum: 5
values.$x1     // true because 10 > maximum

values.x1 = 5 // maximum: 5
values.$x1    // false because 5 <= maximum
