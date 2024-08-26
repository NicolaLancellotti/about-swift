//: [Previous](@previous)
//: # Memory Layout
struct Structure {
  var value4B: Int32 = 0
  var value2B: Int16 = 0
  var value1B: Int8 = 0
}

var instance = Structure()
/*: 
 ### The contiguous memory footprint of T
 
 Do not include any padding necessary for memory alignment.
 */
MemoryLayout<Structure>.size
MemoryLayout.size(ofValue: instance)
/*: 
 ### The minimum memory alignment of T
 
 An alignment of x means that data of this type should (or must, depends on the
 CPU) be stored starting at an address that is a multiple of x.
 */
MemoryLayout<Structure>.alignment
MemoryLayout.alignment(ofValue: instance)
//: ### The number of bytes from the start of one instance of T to the start of the next in an Array<T>
MemoryLayout<Structure>.stride
MemoryLayout.stride(ofValue: instance)
//: ### The offset of an inline stored property within a type’s in-memory representation
MemoryLayout<Structure>.offset(of: \.value4B)
MemoryLayout<Structure>.offset(of: \.value2B)
MemoryLayout<Structure>.offset(of: \.value1B)
//: [Next](@next)
