//: [Previous](@previous)
/*:
 # Ownership
 */
//: ## Noncopyable structs and enums
struct NoncopyableStruct: ~Copyable {
  
  // A noncopyable struct or enum may declare a deinit
  deinit { }
  
  // Ownership of the self parameter
  consuming func consumingSelf() {
    discard self // ends the lifetime of self without running its deinit
  }
  
  borrowing func borrowingSelf() {}
  
  mutating func  mutatingSelf() {}
}
//: ## Parameter ownership modifiers
func foo(_: borrowing NoncopyableStruct) { }

func foo(_: consuming NoncopyableStruct) { }

func foo(_: inout NoncopyableStruct) {}
//: ## Operators
func operators() {
  do {
    let value = NoncopyableStruct()
    let value1 = value // consuming
  }
  
  do {
    let value = NoncopyableStruct()
    _ = value // borrowing
  }
  
  do {
    let value = NoncopyableStruct()
    consume value
    // let value1 = value // error
  }
  
  do {
    let value = ""
    let value1 = copy value // explicit copy
  }
}
//: [Next](@next)
