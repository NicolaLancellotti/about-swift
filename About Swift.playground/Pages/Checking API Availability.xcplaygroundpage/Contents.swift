//: [Previous](@previous)
//: # Checking API Availability
if #available(iOS 9, macOS 10.10, *) {
  // Use iOS 9 APIs on iOS, and use macOS v10.10 APIs on macOS
} else {
  // Fall back to earlier iOS and macOS APIs
}

if #unavailable(iOS 9, macOS 10.10) {

} else {

}
/*:
 The available attribute always appears with a list of two or more
 comma-separated attribute arguments. These arguments begin with one of the
 following platform names:
 
 * iOS
 * iOSApplicationExtension
 * macOS
 * macOSApplicationExtension
 * watchOS
 * watchOSApplicationExtension
 * tvOS
 * tvOSApplicationExtension
 * swift
 
 You can also use an asterisk (`*`) to indicate the availability of the
 declaration on all of the platform names listed above.
 */
@available(iOS, introduced: 2.1, deprecated: 3, obsoleted: 8, message:"message")
@available(tvOS, unavailable)
func function() { }
/*:
 If an available attribute only specifies an introduced argument in addition to
 a platform name argument, the following shorthand syntax can be used instead.
 (The shorthand form is preferred whenever possible.)
 */
@available(iOS 8.0, macOS 10.10, *)
public class MyClass { }
/*:
 You can use the renamed argument in conjunction with the unavailable argument
 and a type alias declaration to indicate to clients of your code that a
 declaration has been renamed. For example, this is useful when the name of a
 declaration is changed between releases of a framework or library.
 */
/*:
 First release
 
 `protocol MyProtocol { }`
 
 Subsequent release renames MyProtocol
 */
protocol MyRenamedProtocol { }

@available(*, unavailable, renamed: "MyRenamedProtocol")
typealias MyProtocol = MyRenamedProtocol
/*:
 ## Function back deployment
 
 When a function with @backDeployed is called, the compiler wraps the invocation
 of the function in a thunk. The thunk checks whether the library entry point
 for the declaration is available at runtime, and invokes it if it is.
 Otherwise, a copy of the function that was emitted into the client is called
 instead.
 */
extension MyClass {
  @available(iOS 8.0, macOS 10.10, *)
  @backDeployed(before: iOS 16.0, macOS 13)
  public final var foo: Int {
    0
  }
}
//: [Next](@next)
