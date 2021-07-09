import Foundation

class NLFoo {
  private let ref: NLFooRef
  
  init(value: Int32) {
    ref = NLFooCreate(value)
  }
  
  var value: Int32 {
    get {
      return NLFooGetValue(ref)
    }
    set {
      NLFooSetValue(ref, newValue)
    }
  }
  
  deinit {
    NLFooRelease(ref)
  }
}
