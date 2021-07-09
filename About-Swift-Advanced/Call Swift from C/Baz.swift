import Foundation

// Baz
class Baz {
  let aString: String
  let anInteger: Int32
  var fooBar: FooBar?
  
  init(aString: String, anInteger: Int32) {
    self.aString = aString
    self.anInteger = anInteger
    print("Baz created")
  }
  
  func printBaz() {
    print("aString: \(aString), anInteger: \(anInteger) anInteger2: \(String(describing: fooBar?.anInteger))")
    
  }
  
  deinit {
    print("Baz released")
  }
  
}

// FooBar
class FooBar {
  let anInteger: Int32
  
  init(anInteger: Int32) {
    self.anInteger = anInteger
    print("FooBar created")
  }
  
  deinit {
    print("FooBar released")
  }
}
