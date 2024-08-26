//: [Previous](@previous)
//: # Access Control
/*:
 ## Modules and source files
 
 * A module is a single unit of code distribution.
 * A source file is a single Swift source code file within a module.
 */
/*:
 ## Access levels
 
 * **Open access** and **public access** enable entities to be used within any
 source file.
 * **Package access** enables entities to be used within the same package.
 * **Internal** access enables entities to be used within any source file from
 their defining module (default).
 * **File-private** access restricts the use of an entity to its own defining
 source file.
 * **Private access** restricts the use of an entity to the enclosing
 declaration, and to extensions of that declaration that are in the same file.
 */
/*:
 Open access applies only to classes and propertys, and it differs from
 public access as follows:
 * Classes with public access, or any more restrictive access level, can be
 subclassed only within the module where they’re defined.
 * Open classes can be subclassed within the module where they’re defined, and
 within any module that imports the module where they’re defined.
 ___
 * propertys with public access, or any more restrictive access level, can
 be overridden by subclasses only within the module where they’re defined
 * Open propertys can be overridden by subclasses within the module where
 they’re defined, and within any module that imports the module where they’re
 defined.

 No entity can be defined in terms of another entity that has a lower (more
 restrictive) access level.
 */
public class PublicClass {                 // explicitly public class
  public var publicProperty = 0            // explicitly public f
  var internalProperty = 0                 // implicitly internal property
  fileprivate var filePrivateProperty = 0  // explicitly file-private property
  private var privateProperty = 0          // explicitly private property
  
  public private(set) var propertyWithPublicGetterAndPrivateSetter = 0
}

class InternalClass {                      // implicitly internal class
  var internalProperty = 0                 // implicitly internal property
  fileprivate var filePrivateProperty = 0  // explicitly file-private property
  private var privateProperty = 0          // explicitly private property
}

fileprivate class FilePrivateClass {       // explicitly file-private class
  var filePrivateProperty = 0              // implicitly file-private property
  private var privateProperty = 0          // explicitly private property
}

private class PrivateClass {               // explicitly private class
  var privateProperty = 0                  // implicitly private property
}
//: [Next](@next)
