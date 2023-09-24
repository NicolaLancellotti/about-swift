//: [Previous](@previous)
//: # Copy-on-write
final class Impl {
  var list: [Int]
  
  init(list: [Int] = []) {
    self.list = list
  }
  
  func copy() -> Impl {
    Impl(list: list)
  }
  
  func incrementFirst(by x: Int) {
    list[0] += x
  }
}

struct MyType {
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
  
  mutating func incrementFirst(by x: Int) {
    mutableImpl.incrementFirst(by: x)
  }
  
}

var value1 = MyType()
let value2 = value1
value1.list.append(1)
value1.incrementFirst(by: 2)

value1.list
value2.list
//: [Next](@next)
