//: [Previous](@previous)

//: # Type Erasure

/*:
 ## Example
 */
protocol Incrementable {
  
  associatedtype T
  var current: T { get }
  mutating func increment() -> T
  func incremented(by value: T) -> Self
}

struct IncrementerBy1: Incrementable {
  
  private(set) var current: Int
  
  mutating func increment() -> Int {
    current += 1
    return current
  }
  func incremented(by value: Int) -> IncrementerBy1 {
    return IncrementerBy1(current: self.current + value)
  }
}

struct IncrementerBy2: Incrementable {
  
  private(set) var current: Int
  
  mutating func increment() -> Int {
    current += 2
    return current
  }
  func incremented(by value: Int) -> IncrementerBy2 {
    return IncrementerBy2(current: self.current + value)
  }
}
/*:
 - note:
 You cannot write: \
 `var incrementer: Incrementable`
 */
struct AnyIncrementable<T>: Incrementable {
  
  private var _current: () -> T
  private let _increment: () -> T
  private let _incremented: (T) -> AnyIncrementable<T>
  
  init<I: Incrementable>(_ instance: I) where I.T == T  {
    var i = instance
    _current = { i.current }
    _increment = { i.increment() }
    _incremented =  { AnyIncrementable(i.incremented(by: $0)) }
  }
  
  var current: T {
    return _current()
  }
  
  mutating func increment() -> T {
    return _increment()
  }
  
  func incremented(by current: T) -> AnyIncrementable<T> {
    return _incremented(current)
  }
  
}

var incrementer: AnyIncrementable<Int>

incrementer = AnyIncrementable(IncrementerBy1(current: 0))
incrementer.increment()
incrementer.increment()
incrementer.incremented(by: 10).current

incrementer = AnyIncrementable(IncrementerBy2(current: 0))
incrementer.increment()
incrementer.increment()
incrementer.incremented(by: 10).current

/*:
 ## Type-erased in Swift Standard Library
 * AnyHashable
 * AnyIndex
 * AnyIterator
 * AnySequence
 * AnyCollection
 * AnyBidirectionalCollection
 * AnyRandomAccessCollection
 */
let array = [1, 2, 3]
let range = (1..<3)

var anyCollection: AnyCollection<Int>
anyCollection = AnyCollection(array)
anyCollection = AnyCollection(range)
//: [Next](@next)
