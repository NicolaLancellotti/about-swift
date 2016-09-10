//: [Previous](@previous)

//: # Memory

//: ## Memory Layout
struct Structure {
    let value2: Int32 = 0
    let value0: Int16 = 0
    let value1: Int8 = 0
}

let instance = Structure()

/*: 
 ### The contiguous memory footprint of T.

 Do not include any padding necessary for memory alignment.
 */
MemoryLayout<Structure>.size
MemoryLayout.size(ofValue: instance)
/*: 
 ### The minimum memory alignment of T.

 An alignment of x means that data of this type should (or must, depends on the CPU) be stored starting at an address that is a multiple of x.
  */
MemoryLayout<Structure>.alignment
MemoryLayout.alignment(ofValue: instance)
/*: 
 ### The number of bytes from the start of one instance of T to the start of the next in an Array<T>.
 */
MemoryLayout<Structure>.stride
MemoryLayout.stride(ofValue: instance)
//: [Next](@next)
