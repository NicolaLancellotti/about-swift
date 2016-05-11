//: [Previous](@previous)
import Foundation
//: # Classes

/*:
 - note:
 Classes are Reference Types
 */

/*:
 ## Identity Operators
 * Identical to ===
 * Not identical to !==
 */
class ClassIdentityOperators {
    
}
let object1 = ClassIdentityOperators()
let object2 = ClassIdentityOperators()
let object3 = object1

object1 === object2
object1 === object3

/*:
 ## Methods and Properties
 
 Property observers, Computed properties and Subscripts are like structures.
 */

class ClassWithMethodsAndProperties {
    
    //_____________________________________________
    // Instance Property
    
    // Allow subclasses to Overriding:
    //      Property Getters Setters.
    //      Property Observers.
    var storedProperty = ""
    
    var computedProperty: Int {
        set { }
        get { return 0 }
    }
    
    // Do not allow subclasses to Overriding:
    //      Property Getters Setters.
    //      Property Observers.
    final var finalStoredProperty = ""
    
    final var finalComputedProperty: Int {
        set { }
        get { return 0 }
    }
    
    //_____________________________________________
    // Instance Instance Methods
    
    // Allow subclasses to override the superclass’s implementation.
    func instanceMethod() {
        
    }
    
    // Do not allow subclasses to override the superclass’s implementation.
    final func finalInstanceMethod() {
        
    }
    
    //_____________________________________________
    // Type Property
    
    // Allow subclasses to Overriding:
    //      Property Getters Setters.
    //      Property Observers.
    
    class var typeComputedProperty: Int {
        set { }
        get { return 0 }
    }
    
    // Do not allow subclasses to Overriding:
    //      Property Getters Setters.
    //      Property Observers.
    
    static var staticTypeComputedProperty: Int {
        set { }
        get { return 0 }
    }
    
    // class stored propety aren't supported, only static stored property are supported
    // so it is not possible Overriding Property Getters Setters and Overriding Property Observers.
    static var typeStoredProperty = 0
    
    //_____________________________________________
    // Type Methods
    
    // Allow subclasses to override the superclass’s implementation.
    class func typeClassMethod() {
        
    }
    
    // Do not allow subclasses to override the superclass’s implementation.
    static func staticTypeClassMethod() {
        
    }
    
}

/*:
 ## Requiring Dynamic Dispatch
 
 When Swift APIs are imported by the Objective-C runtime, there are no guarantees of dynamic dispatch for properties, methods, subscripts, or initializers. The Swift compiler may still devirtualize or inline member access to optimize the performance of your code, bypassing the Objective-C runtime.
 
 
 You can use the **dynamic** modifier to require that access to members be dynamically dispatched through the Objective-C runtime.
 */
class ClassWithRequiringDynamicDispatch {
    
    dynamic var variable: String = ""
    
    dynamic func foo() {
        
    }
}

//: ## Inheritance
class SomeSuperclass {
    
    var description: String {
        return "SomeSuperclass"
    }
    
    var someProperty: Double = 0.0
    
    func someMethod() {
        print("SomeSuperclass - someMethod")
    }
    
}

class SomeSubclass: SomeSuperclass {
    // You must always state both the name and the type of the property you are overriding.
    
    
    // Overriding Property Getters and Setters
    //
    // You can present an inherited read-only property as a read-write property by providing both a
    // getter and a setter but not the contrary.
    override var description: String {
        return super.description + "- SomeSubclass"
    }
    
    
    // Overriding Property Observers
    // Property observers can be added to any property (stored or computed property).
    
    // When you assign a default value to a stored property, or set its initial value within an
    // initializer, the value of that property is set directly, without calling any property observers.
    
    // The willSet and didSet observers of superclass properties are called when a property is set in
    // a subclass initializer.
    
    // You cannot add property observers to inherited constant stored properties or inherited read-only
    // computed properties.
    override var someProperty: Double {
        didSet {
            
        }
    }
    
    // Overriding Methods
    override func someMethod() {
        print("SomeSubclass - someMethod")
    }
    
}

/*:
 You cannot provide both an overriding setter and an overriding property observer for the same property.
 
 If you want to observe changes to a property’s value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.
 */

/*:
 ## Initialization
 Class instances do not receive a default memberwise initialize.
 ### Designated initializers
 Every class must have at least one designated initializer.
 
 * Fully initializes all properties.
 * Delegates up to a superclass initializer.
 * Assigning a value to an inherited property.
 
 
 ### Convenience initializers
 Convenience initializers are secondary, supporting initializers for a class.
 
 Convenience initializers are written  with the convenience modifier placed before the init keyword.
 
 * Delegate across to another initializer.
 * Assigning a value to any property (including properties defined by the same class).
 
 
 */

class SomeSuperClass {
    
    var propertySuperClass: Int = 0
    
}

class SomeSubClass: SomeSuperClass {
    
    var propertySubClass1: Int
    var propertySubClass2: Int
    
    // Designated Initializers
    
    init(propertySubClass1: Int, propertySubClass2: Int) {
        // Fully initializes all properties.
        self.propertySubClass1 = propertySubClass1
        self.propertySubClass2 = propertySubClass2
        
        // Delegates up to a superclass initializer.
        super.init()
        
        // Assigning a value to an inherited property.
        propertySuperClass = 1
        
    }
    
    override init() {
        // Fully initializes all properties.
        self.propertySubClass1 = 1
        self.propertySubClass2 = 2
        
        // Delegates up to a superclass initializer.
        super.init()
    }
    
    // Convenience Initializers
    
    convenience init(propertySubClass1: Int) {
        //    Delegate across to another initializer.
        self.init()
        
        //    Assigning a value to any property (including properties defined by the same class).
        self.propertySubClass1 = propertySubClass1
    }
    
}


/*:
 ### Inheritance
 * You always write the override modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer.
 * Swift subclasses do not inherit their superclass initializers by default.
 
 ### Automatic Initializer Inheritance
 Assuming that you provide default values for any new properties you introduce in a subclass.
 
 * If your subclass doesn’t define any designated initializers.
 it automatically inherits all of its superclass designated initializers.
 
 * If your subclass provides an implementation of all of its superclass designated initializers
 then it automatically inherits all of the superclass convenience initializers.
 */

/*:
 ### Failable initializer
 
 You can override a failable initializer with a nonfailable initializer but not the other way around.
 
 A failable initializer can delegate to any kind of initializer. A nonfailable initializer can delegate to another nonfailable initializer or to an init! failable initializer. A nonfailable initializer can delegate to an init? failable initializer by force-unwrapping the result of the superclass’s initializer—for example, by writing super.init()!.
 
 Initialization failure propagates through initializer delegation. Specifically, if a failable initializer delegates to an initializer that fails and returns nil, then the initializer that delegated also fails and implicitly returns nil.
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

class SubClassWithFailableInitializer: ClassWithFailableInitializer {
    
    // Override a failable initializer with a nonfailable initializer
    override init(property: Int) {
        super.init()
        if property < 0 {
            self.property = 0
        }
    }
    
}
/*:
 ### Required Initializers
 
 Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:
 
 * You must also write the required modifier before every subclass implementation of a required initializer.
 * You do not write the override modifier when overriding a required designated initializer.
 
 
 You do not have to provide an explicit implementation of a required initializer if you can satisfy the requirement with an inherited initializer.
 */
class ClassWithRequiredInitializer {
    required init() {
        
    }
}

class SubClassWithRequiredInitializer: ClassWithRequiredInitializer {
    required init() {
        
    }
}
/*:
 ## Deinitialization
 
 * The superclass deinitializer is called automatically at the end of a subclass deinitializer implementation.
 * Superclass deinitializers are always called, even if a subclass does not provide its own deinitializer.
 * The subclass object is not deallocated until all deinitializers in its inheritance chain have finished executing.
 */

class ClassWithDeinit {
    deinit {
        
    }
}

/*:
 ## Automatic Reference Counting
 * Weak references must be declared as variables, to indicate that their value can change at runtime.
 * If you try to access an unowned reference after the instance that it references is deallocated, you will trigger a runtime error.
 */

/*:
 - note: See ARC.pdf in Resources
 */

//: ## Distinguish between methods or initializers whose names differ only by the names of their arguments

class SomeClass {
    func someMethod(x: Int, y: Int) {}
    func someMethod(x: Int, z: Int) {}
    func overloadedMethod(x: Int, y: Int) {}
    func overloadedMethod(x: Int, y: Bool) {}
}
let instance = SomeClass()

//let a = instance.someMethod              // Ambiguous
let b = instance.someMethod(_:y:)        // Unambiguous

//let c = instance.overloadedMethod        // Ambiguous
//let d = instance.overloadedMethod(_:y:)  // Still ambiguous
let e: (Int, Bool) -> Void  = instance.overloadedMethod(_:y:)  // Unambiguous


//: [Next](@next)


