//: [Previous](@previous)

//: # Access Control

/*:
 ## Modules and Source Files
 * A module is a single unit of code distribution.
 * A source file is a single Swift source code file within a module.
 */

/*:
 ## Access Levels
 * Public access enables entities to be used within any source file.
 * Internal access enables entities to be used within any source file from their defining module (default).
 * Private access restricts the use of an entity to its own defining source file.
 */

/*:
 ## Custom Types
 No entity can be defined in terms of another entity that has a lower (more restrictive) access level.
 */


public class SomePublicClass {          // explicitly public class
    public var somePublicProperty = 0   // explicitly public class member
    var someInternalProperty = 0        // implicitly internal class member
    private func somePrivateMethod() {} // explicitly private class member
}

class SomeInternalClass {               // implicitly internal class
    var someInternalProperty = 0        // implicitly internal class member
    private func somePrivateMethod() {} // explicitly private class member
}

private class SomePrivateClass {        // explicitly private class
    var somePrivateProperty = 0         // implicitly private class member
    func somePrivateMethod() {}         // implicitly private class
}


//: ## Swift allows the get of a property to be more accessible than its set
public struct TrackedString {
    
    public private(set) var numberOfEdits = 0
    
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    
    public init() {}
}


//: [Next](@next)
