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
class ClassWithCustomMirror: CustomReflectable {
  
  let value = 10
  
  var customMirror: Mirror{
    return Mirror(self, children: ["value": "*** \(value) ***"])
  }
}

let customMirror = Mirror(reflecting: ClassWithCustomMirror())

customMirror.children.first?.label
customMirror.children.first?.value
//: [Next](@next)
