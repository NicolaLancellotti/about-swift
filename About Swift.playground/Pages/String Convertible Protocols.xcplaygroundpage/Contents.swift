//: [Previous](@previous)

//: # Convertible Protocols
struct SomeStructure {
    
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
/*:
 ## LosslessStringConvertible
 A type that can be represented as a string in a lossless, unambiguous way.
*/
struct Person {
    let firstName: String
    let secondName: String
}

extension Person: LosslessStringConvertible {
    init?(_ description: String) {
        let array = description.characters.split(separator: "|").map{ String($0) }
        guard array.count == 2 else {
            return nil
        }
        firstName = array[0]
        secondName = array[1]
    }
    
    var description: String {
        return firstName + "|" + secondName
    }
}

let nicola = Person(firstName: "Nicola", secondName: "Lancellotti")
let description = nicola.description
let anotherNicola = Person(description)
//: [Next](@next)
