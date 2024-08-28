class Owner {
  let string: String
  let integer: Int32
  var value: Value?
  
  init(string: String, integer: Int32) {
    self.string = string
    self.integer = integer
    print("Owner created")
  }
  
  func dump() {
    print("string: \(string), integer: \(integer) value: \(String(describing: value?.integer))")
    
  }
  
  deinit {
    print("Owner released")
  }
  
}

class Value {
  let integer: Int32
  
  init(integer: Int32) {
    self.integer = integer
    print("Value created")
  }
  
  deinit {
    print("Value released")
  }
}
