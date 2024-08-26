//: [Previous](@previous)
//: # Observation
import Observation

@Observable
class Model {
  var trackedProperty: String = ""
  
  @ObservationIgnored
  var untrackedProperty: String = ""
  
  // This property is tracked because it derives its value
  // from a tracked stored property.
  var trackedStoredProperty1: String {
    trackedProperty.lowercased()
  }
  
  // This property is not automatically tracked because it derives its value
  // from an untracked stored property.
  // It manually adds tracking using the generated access(keyPath:) and
  // withMutation(keyPath:) methods.
  var trackedStoredProperty2: String {
    get {
      self.access(keyPath: \.trackedStoredProperty2)
      return untrackedProperty
    }
    set {
      self.withMutation(keyPath: \.trackedStoredProperty2) {
        untrackedProperty = newValue
      }
    }
  }
}
/*:
 ## withObservationTracking
 - Any access to a tracked property within the apply closure will flag the
 property.
 - Any change to a flagged property will trigger a call to the onChange closure.
 */
var model = Model()

withObservationTracking {
  // The apply closure accesses `trackedStoredProperty1` which accesses `trackedProperty`
  print(model.trackedStoredProperty1)
  
} onChange: {
  // The onChange closure will trigger when `trackedStoredProperty1`
  // or `trackedProperty` change.
  print("The model has changed")
}
//: [Next](@next)
