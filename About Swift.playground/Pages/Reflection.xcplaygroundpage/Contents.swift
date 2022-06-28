//: [Previous](@previous)
//: # Reflection
class SomeSuperClass {
  let intValue = 0
}

class SomeBaseClass: SomeSuperClass {
  let stringValue = "A string"
  let boolValue = true
}
/*:
 ## Mirror
 
 Describes the parts that make up a particular instance.
 */
let mirror = Mirror(reflecting: SomeBaseClass())

mirror.displayStyle
mirror.subjectType
mirror.superclassMirror?.subjectType

mirror.children.count
let firstChildren = mirror.children.first!
firstChildren.label
firstChildren.value
/*:
 ## CustomReflectable
 
 A type that explicitly supplies its own mirror.
 */
struct Temperature: CustomReflectable {
  var celsiusDegrees: Float

  var customMirror: Mirror {
    Mirror(self, children: [
      "C" : celsiusDegrees,
      "F" : 1.8 * celsiusDegrees + 32
    ])
  }
}

let temperature = Temperature(celsiusDegrees: 20)
//: [Next](@next)
