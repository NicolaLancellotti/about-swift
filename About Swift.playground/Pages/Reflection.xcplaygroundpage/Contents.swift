//: [Previous](@previous)
//: # Reflection
class Superclass {
  let intValue = 0
}

class Class: Superclass {
  let stringValue = "A string"
  let boolValue = true
}
/*:
 ## Mirror
 
 Describes the parts that make up a particular instance.
 */
let mirror = Mirror(reflecting: Class())
mirror.subjectType == Class.self
mirror.displayStyle
let children = Array(mirror.children)
mirror.superclassMirror?.children.first
children[0]
children[1]
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
dump(temperature)
//: [Next](@next)
