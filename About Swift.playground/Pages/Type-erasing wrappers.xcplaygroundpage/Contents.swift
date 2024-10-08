//: [Previous](@previous)
//: # Type-erasing wrappers
protocol Incrementable<T> {
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
    IncrementerBy1(current: self.current + value)
  }
}

struct IncrementerBy2: Incrementable {
  private(set) var current: Int
  
  mutating func increment() -> Int {
    current += 2
    return current
  }
  
  func incremented(by value: Int) -> IncrementerBy2 {
    IncrementerBy2(current: self.current + value)
  }
}

do {
  struct AnyIncrementable<T>: Incrementable {
    private var wrapped: any Incrementable<T>
    
    init(_ wrapped: any Incrementable<T>) {
      self.wrapped = wrapped
    }
    
    var current: T {
      wrapped.current
    }
    
    mutating func increment() -> T {
      wrapped.increment()
    }
    
    func incremented(by value: T) -> AnyIncrementable<T> {
      AnyIncrementable(wrapped.incremented(by: value))
    }
  }
  
  var anyIncrementer: AnyIncrementable<Int>
  
  anyIncrementer = AnyIncrementable(IncrementerBy1(current: 0))
  anyIncrementer.increment()
  anyIncrementer.increment()
  anyIncrementer.incremented(by: 10).current
  
  anyIncrementer = AnyIncrementable(IncrementerBy2(current: 0))
  anyIncrementer.increment()
  anyIncrementer.increment()
  anyIncrementer.incremented(by: 10).current
}

do {
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
      _current()
    }
    
    mutating func increment() -> T {
      _increment()
    }
    
    func incremented(by value: T) -> AnyIncrementable<T> {
      _incremented(value)
    }
  }
  
  var anyIncrementer: AnyIncrementable<Int>
  
  anyIncrementer = AnyIncrementable(IncrementerBy1(current: 0))
  anyIncrementer.increment()
  anyIncrementer.increment()
  anyIncrementer.incremented(by: 10).current
  
  anyIncrementer = AnyIncrementable(IncrementerBy2(current: 0))
  anyIncrementer.increment()
  anyIncrementer.increment()
  anyIncrementer.incremented(by: 10).current
}
/*:
 ## Type-erasing wrappers in the Swift Standard Library
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
