//: [Previous](@previous)
//: # Synchronization
import Synchronization
import Foundation
/*:
 ## Atomics
 */
Atomic<Int /* AtomicRepresentable */>(0)
/*:
 ### Operations
 The memory ordering arguments of all atomic operations must be compile-time
 constants.
 */
do {
  let atomic = Atomic<Int>(0)
  
  // Basic operations
  atomic.load(ordering: .sequentiallyConsistent)
  atomic.store(1, ordering: .sequentiallyConsistent)
  atomic.exchange(2, ordering: .sequentiallyConsistent)
  atomic.compareExchange(expected: 2, desired: 3,
                         successOrdering: .sequentiallyConsistent,
                         failureOrdering: .sequentiallyConsistent)
  // It is allowed to spuriously fail
  atomic.weakCompareExchange(expected: 3, desired: 4,
                             successOrdering: .sequentiallyConsistent,
                             failureOrdering: .sequentiallyConsistent)
  
  // Integer operations
  atomic.add(1, ordering: .sequentiallyConsistent)
  atomic.bitwiseAnd(7, ordering: .sequentiallyConsistent)
  atomic.min(10, ordering: .sequentiallyConsistent)
  // etc.
  
  // Boolean operations
  let boolAtomic = Atomic<Bool>(true)
  boolAtomic.logicalAnd(true, ordering: .sequentiallyConsistent)
  // etc.
}
/*:
 ### WordPair
 A pair of two word sized `UInts`.
 
 This type’s primary purpose is to be used in double wide atomic operations.
 */
Atomic<WordPair>(.init(first: 0, second: 1))
/*:
 ### AtomicLazyReference
 A lazily initializable atomic strong reference.
 */
do {
  class Class {}
  
  let _instance = AtomicLazyReference<Class>()
  
  var threadSafeLazyInstance: Class {
    switch _instance.load() {
    case .some(let instance): instance
    case .none:  _instance.storeIfNil(Class())
    }
  }
}
/*:
 ### Custom atomic types
 `AtomicRepresentable` and `AtomicOptionalRepresentable` provide a full set of
 default implementations for `RawRepresentable` types whose raw value is
 itself atomic.
 */
struct Struct {
  let x: Int
}

extension Struct : RawRepresentable, AtomicRepresentable {
  var rawValue: Int { x }
  
  init?(rawValue: Int) {
    self.x = rawValue
  }
}

Atomic<Struct>(.init(x: 1))
/*:
 ### Memory fence
 Establishes a memory ordering without associating it with a particular atomic
 operation.
 */
atomicMemoryFence(ordering: .sequentiallyConsistent)
/*:
 ## Mutex
 A synchronization primitive that protects shared mutable state via mutual
 exclusion.
 */
do {
  let mutex = Mutex<[String: Int]>([:])
  
  DispatchQueue.concurrentPerform(iterations: 10) { index in
    let key = index.isMultiple(of: 2) ? "a" : "b"
    mutex.withLock {
      $0[key, default: 0] += 1
    }
  }
  mutex.withLockIfAvailable {
    $0
  }
}
//: [Next](@next)
