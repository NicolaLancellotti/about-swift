//: [Previous](@previous)

//: # Memory

//: ## Memory Layout
struct Structure {
    var value2: Int32 = 0
    var value0: Int16 = 0
    var value1: Int8 = 0
}

var instance = Structure()

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
/*:
 ### The offset of an inline stored property within a type’s in-memory representation
 */
let value0KeyPath: PartialKeyPath<Structure> = \.value0
MemoryLayout<Structure>.offset(of: value0KeyPath)

let value1KeyPath: PartialKeyPath<Structure> = \.value1
MemoryLayout<Structure>.offset(of: value1KeyPath)

let value2KeyPath: PartialKeyPath<Structure> = \.value2
MemoryLayout<Structure>.offset(of: value2KeyPath)

instance.value0
withUnsafePointer(to: &instance) {
    let pointer = UnsafeMutableRawPointer(mutating: $0) + MemoryLayout<Structure>.offset(of: value0KeyPath)!
    pointer.assumingMemoryBound(to: Int16.self).pointee = 10
}
instance.value0
//: [Next](@next)
