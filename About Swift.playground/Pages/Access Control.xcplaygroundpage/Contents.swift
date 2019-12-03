//: [Previous](@previous)

//: # Access Control

/*:
 ## Modules and Source Files
 * A module is a single unit of code distribution.
 * A source file is a single Swift source code file within a module.
 */

/*:
 ## Access Levels
 * **Open access** and **public access** enable entities to be used within any source file.
 * **Internal** access enables entities to be used within any source file from their defining module (default).
 * **File-private** access restricts the use of an entity to its own defining source file.
 * **Private access** restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file.
 */

/*:
 Open access applies only to classes and class members, and it differs from public access as follows:
 * Classes with public access, or any more restrictive access level, can be subclassed only within the module where they’re defined.
 * Open classes can be subclassed within the module where they’re defined, and within any module that imports the module where they’re defined.
 ___
 * Class members with public access, or any more restrictive access level, can be overridden by subclasses only within the module where they’re defined
 * Open class members can be overridden by subclasses within the module where they’re defined, and within any module that imports the module where they’re defined.
 */

/*:
 ## Custom Types
 No entity can be defined in terms of another entity that has a lower (more restrictive) access level.
 */
public class SomePublicClass {                   // explicitly public class
  public var somePublicProperty = 0            // explicitly public class member
  var someInternalProperty = 0                 // implicitly internal class member
  fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
  private func somePrivateMethod() {}          // explicitly private class member
}

class SomeInternalClass {                        // implicitly internal class
  var someInternalProperty = 0                 // implicitly internal class member
  fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
  private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class SomeFilePrivateClass {         // explicitly file-private class
  func someFilePrivateMethod() {}              // implicitly file-private class member
  private func somePrivateMethod() {}          // explicitly private class member
}

private class SomePrivateClass {                 // explicitly private class
  func somePrivateMethod() {}                  // implicitly private class member
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
