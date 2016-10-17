//: [Previous](@previous)

//: # Convertible Protocols
struct SomeStructure {
    var value: Int = 0
}

let instance = SomeStructure()
/*:
 ## CustomStringConvertible
 Accessing a type's description property directly or using CustomStringConvertible as a generic constraint is discouraged.
 */
extension SomeStructure: CustomStringConvertible {
    var description: String {
        return "my description"
    }
}

print(instance)
String(describing: instance)
/*:
 ## CustomDebugStringConvertible
 Accessing a type's debugDescription property directly or using CustomDebugStringConvertible as a generic constraint is discouraged.
 */
extension SomeStructure: CustomDebugStringConvertible {
    var debugDescription: String {
        return "my debug description"
    }
}

debugPrint(instance)
String(reflecting: instance)
//: [Next](@next)
