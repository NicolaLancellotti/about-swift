//: [Previous](@previous)

//: # Attributes

/*:
 ## Discardable Result
 
 Apply this attribute to a function or method declaration to suppress the compiler warning when the function or method that returns a value is called without using its result.
 */
struct Increaser {
    var value = 0
    
    @discardableResult
    func increased() -> Int {
        return value + 1
    }
}
/*:
 ## Cross-module inlining and specialization
 Apply *inlinable* attribute to a function, method, computed property, subscript, convenience initializer, or deinitializer declaration to expose that declaration’s implementation as part of the module’s public interface. The compiler is allowed to replace calls to an inlinable symbol with a copy of the symbol’s implementation at the call site.
 
 Inlinable code can interact with public symbols declared in any module, and it can interact with internal symbols declared in the same module that are marked with the usableFromInline attribute.
 
 
 Apply *usableFromInline* attribute to a function, method, computed property, subscript, initializer, or deinitializer declaration to allow that symbol to be used in inlinable code that’s defined in the same module as the declaration. The declaration must have the internal access level modifier.
 
 Like the public access level modifier, *usableFromInline* attribute exposes the declaration as part of the module’s public interface. Unlike public, the compiler doesn’t allow declarations marked with *usableFromInline* to be referenced by name in code outside the module, even though the declaration’s symbol is exported.
 */
@inlinable
public func foo() {
    bar()
}

@usableFromInline
internal func bar() {
    
}
/*:
 ## Dynamic Member Lookup
 
 Apply this attribute to a class, structure, enumeration, or protocol to enable members to be looked up by name at runtime.
 
 In an explicit member expression, if there isn’t a corresponding declaration for the named member, the expression is understood as a call to the type’s subscript(dynamicMemberLookup:) subscript, passing a string literal that contains the member’s name as the argument. The subscript’s parameter type can be any type that conforms to the ExpressibleByStringLiteral protocol, and its return type can be any type.
 */
@dynamicMemberLookup
class DynamicDictionary {
    
    private var dictionary = [String: String]()
    
    subscript(dynamicMember member: String) -> String? {
        get {
            return dictionary[member]
        }
        set {
            dictionary[member] = newValue
        }
    }
}

let dic = DynamicDictionary()
dic.name
dic.name = "Nicola"
dic[dynamicMember: "name"]
//: [Next](@next)
