//: [Previous](@previous)
//: # Synchronization
import Synchronization
import Foundation
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
