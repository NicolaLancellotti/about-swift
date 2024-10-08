//: [Previous](@previous)
//: # Attributes
/*:
 ## Discardable result
 
 Apply this attribute to a function or method declaration to suppress the
 compiler warning when the function or method that returns a value is called
 without using its result.
 */
@discardableResult
func lowercase(_ value: inout String) -> String {
  value = value.lowercased()
  return value
}

do {
  var string = "ABC"
  lowercase(&string)
  string
}
/*:
 ## Cross-module inlining and specialization
 
 Apply *inlinable* attribute to a function, method, computed property,
 subscript, convenience initializer, or deinitializer declaration to expose that
 declaration’s implementation as part of the module’s public interface. The
 compiler is allowed to replace calls to an inlinable symbol with a copy of the
 symbol’s implementation at the call site.
 
 Inlinable code can interact with public symbols declared in any module, and it
 can interact with internal symbols declared in the same module that are marked with the usableFromInline attribute.
 
 
 Apply *usableFromInline* attribute to a function, method, computed property,
 subscript, initializer, or deinitializer declaration to allow that symbol to
 be used in inlinable code that’s defined in the same module as the declaration.
 The declaration must have the internal access level modifier.
 
 Like the public access level modifier, *usableFromInline* attribute exposes the
 declaration as part of the module’s public interface. Unlike public, the
 compiler doesn’t allow declarations marked with *usableFromInline* to be
 referenced by name in code outside the module, even though the declaration’s
 symbol is exported.
 */
@inlinable
public func inlinable() {
  usableFromInline()
}

@usableFromInline
internal func usableFromInline() { }
/*:
 ## Dynamic member lookup
 
 Apply this attribute to a class, structure, enumeration, or protocol to enable
 members to be looked up by name at runtime.
 
 In an explicit member expression, if there isn’t a corresponding declaration
 for the named member, the expression is understood as a call to the type’s
 `subscript(dynamicMemberLookup:)` subscript, passing information about the
 member as the argument. The subscript can accept a parameter that’s either a
 key path or a member name.
 In case both string-based and keypath-based overloads match, keypath takes
 priority.
 
 It can accept member names using an argument of a type that conforms to the
 `ExpressibleByStringLiteral` protocol—in most cases, `String`. The subscript’s
 return type can be any type.
 */
@dynamicMemberLookup
class DynamicDictionary {
  private var dictionary = [String: String]()
  
  subscript(dynamicMember member: String) -> String? {
    get { dictionary[member] }
    set { dictionary[member] = newValue }
  }
}

let dic = DynamicDictionary()
dic.key
dic.key = "value"
dic[dynamicMember: "key"]
//: ### Key path member lookup
@dynamicMemberLookup
class Box<T> {
  private let getter: () -> T
  private let setter: (T) -> Void
  
  var value: T {
    get { getter() }
    set { setter(newValue) }
  }
  
  private init(getter: @escaping () -> T,
               setter: @escaping (T) -> Void) {
    self.getter = getter
    self.setter = setter
  }
  
  convenience init(_ value: T) {
    var value = value
    self.init(getter: { value }, setter: { value = $0 })
  }
  
  subscript<U>(dynamicMember keyPath: WritableKeyPath<T, U>) -> Box<U> {
    Box<U>(
      getter: { self.value[keyPath: keyPath] },
      setter: { self.value[keyPath: keyPath] = $0 })
  }
}

struct Point {
  var x: Int
  var y: Int
}

let box1 = Box(Point(x: 0, y: 1))
let box2 = box1

box1.x.value = 10
box2.x.value
/*:
 ## Dynamic callable
 
 Apply this attribute to a class, structure, enumeration, or protocol to treat
 instances of the type as callable functions.
 
 The type must implement either a `dynamicallyCall(withArguments:)` method, a
 `dynamicallyCall(withKeywordArguments:)` method, or both.
 */
@dynamicCallable
struct DynamicCallableStruct {
  func dynamicallyCall(withArguments arguments: [Int]) -> String {
    "dynamically call with arguments: \(arguments)"
  }
  
  func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Int>) -> String {
    "dynamically call with keyword arguments: \(pairs)"
  }
}

let callable = DynamicCallableStruct()
callable(1, 2)
callable(x: 1, y: 2)

callable.dynamicallyCall(withArguments: [1, 2])
callable.dynamicallyCall(withKeywordArguments: ["x": 1, "y": 2])
/*:
 ## Main
 
 Apply this attribute to a structure, class, or enumeration declaration to
 indicate that it contains the top-level entry point for program flow.
 ```
 // In a framework:
 public protocol Application { }
 
 extension Application {
   public static func main() throws { }
 }

 // In an executable:
 @main
 struct Program: Application { }
 ```
 */
//: [Next](@next)
