//: [Previous](@previous)
//: # Copy-on-write
struct Cow {
  private final class Impl {
    var list: [Int]
    
    init(list: [Int] = []) {
      self.list = list
    }
    
    func copy() -> Impl {
      Impl(list: list)
    }
  }
  
  private var impl = Impl()

  private var mutableImpl: Impl {
    mutating get {
      if !isKnownUniquelyReferenced(&impl) { impl = impl.copy() }
      return impl
    }
  }
  
  var list: [Int] {
    get { impl.list }
    set { mutableImpl.list = newValue }
  }

}

var value1 = Cow()
let value2 = value1
value1.list.append(1)

value1.list
value2.list
//: [Next](@next)
