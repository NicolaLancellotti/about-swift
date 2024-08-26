//: [Previous](@previous)
//: # Pointers
/*:
 ## Pointers for typed data
 
 * `UnsafeMutablePointer` - mutating pointer.
 * `UnsafePointer` - non-mutating pointer.
 */
//: ### Allocate
let intArray = UnsafeMutablePointer<Int>.allocate(capacity: 2)
//: ### Initialize
intArray.initialize(repeating: 10, count: 2)
//: ### Work
intArray[0]
intArray[1]

intArray.update(repeating: 11, count: 2)

intArray.pointee
intArray.successor().pointee

intArray.advanced(by: 0).pointee
intArray.advanced(by: 1).pointee

intArray.distance(to: intArray.successor())
/*
 Equivalent to
 { defer { p.deinitialize(count: 1) }; return pointee }()
 but more efficient.
 */
intArray.move()
//: ### Deinitialize
intArray.deinitialize(count: 2)
//: ### Deallocate
intArray.deallocate()
//: ### Example deinitialization
do {
  class Class {
    deinit {
      print("deinit")
    }
  }
  
  struct Structure {
    var value: Class
    
    init(_ value: Class) {
      self.value = value
    }
    
  }
  
  let p = UnsafeMutablePointer<Structure>.allocate(capacity: 1)
  p.initialize(repeating: Structure(Class()),
               count: 1)
  
  p.deinitialize(count: 1) // print "deinit" in the console
  p.deallocate()
}
//: ### Temporarily rebinds the memory
var tuple = (false, true)
withUnsafeMutablePointer(to: &tuple) {
  $0.withMemoryRebound(to: Bool.self, capacity: 2) { pointer in
    pointer[0] = !pointer[0]
    pointer[1] = !pointer[1]
  }
}
tuple
//: ### Obtain a pointer to a stored property
do {
  struct Structure {
    var float: Float = 1.1
    var bool: Bool = true
  }
  
  do {
    var value = Structure()
    withUnsafeMutablePointer(to: &value) {
      let pointer = $0.pointer(to: \.bool)!
      pointer.pointee.toggle()
    }
    value.bool
  }
  do {
    var value = Structure()
    let offset = MemoryLayout.offset(of: \Structure.bool)
    withUnsafePointer(to: &value) {
      let pointer = UnsafeMutableRawPointer(mutating: $0) + offset!
      pointer.assumingMemoryBound(to: Bool.self).pointee.toggle()
    }
    value.bool
  }
}
/*:
 ## Pointers for untyped data
 
 * `UnsafeMutableRawPointer` - mutating pointer.
 * `UnsafeRawPointer` - non-mutating pointer.
 
 A memory location may only be bound to one type at a time.
 */
let rawPointer: UnsafeMutableRawPointer = {
  let int16Pointer = UnsafeMutablePointer<UInt16>.allocate(capacity: 1)
  int16Pointer.initialize(to: 0xabcd)
  return UnsafeMutableRawPointer(int16Pointer)
}()

String(rawPointer.advanced(by: 0).load(as: UInt8.self), radix: 16)
String(rawPointer.advanced(by: 1).load(as: UInt8.self), radix: 16)
rawPointer.storeBytes(of: 0xff, as: UInt8.self)

// Use this method when you have a raw pointer to memory that has already
// been bound to the specified type.
let uint16Pointer = rawPointer.assumingMemoryBound(to: UInt16.self)
String(uint16Pointer.pointee, radix: 16)

// Bind or rebind to the specified type
let uint8Pointer = rawPointer.bindMemory(to: UInt8.self, capacity: 2)
// Accessing int16Pointer is now undefined
String(uint8Pointer.advanced(by: 0).pointee, radix: 16)
String(uint8Pointer.advanced(by: 1).pointee, radix: 16)

rawPointer.deallocate()
/*: ### You can obtain the next/preceding pointer properly aligned with
 `alignedUp(for:)` and `alignedDown(for:)`
 */
/*:
 ## Buffer pointers
 
 A non-owning pointer to a buffer of elements
 stored contiguously in memory, presenting a collection interface to the
 underlying elements.
 
 * `UnsafeMutableBufferPointer` - for mutating elements.
 * `UnsafeBufferPointer` - for non-mutating elements.
 */
let storage = UnsafeMutablePointer<Int>.allocate(capacity: 10)
let buffer = UnsafeMutableBufferPointer(start: storage, count: 10)
defer {
  buffer.deallocate()
}

buffer.baseAddress

buffer.makeIterator()

(0..<buffer.count).map {
  buffer[$0] = $0
}

buffer.reduce(0, +)
//: Efficient temporarily allocation which will be optimized to use stack allocation when possible
withUnsafeTemporaryAllocation(of: Int.self, capacity: 10) {
  (buffer: UnsafeMutableBufferPointer<Int>) in
}
/*:
 ## Buffer pointers for untyped data
 
 * `UnsafeMutableRawBufferPointer` - mutating buffer pointer.
 * `UnsafeRawBufferPointer` - non-mutating buffer pointer.
 */
//: ### Unaligned loads and stores
import Foundation
let data = Data([0x0, 0x0, 0x0, 0xff, 0xff, 0xff, 0xff, 0x0])
let unalignedData = data.dropFirst(3)

unalignedData.withUnsafeBytes { (buffer: UnsafeRawBufferPointer) in
  buffer.loadUnaligned(as: UInt32.self)
}

// Fatal error: load from misaligned raw pointer
// unalignedData.withUnsafeBytes { $0.load(as: UInt32.self) }
/*:
 ## Managed buffer
 
 A class whose instances contain a property of type `Header` and raw storage for
 an array of `Element`, whose size is determined at instance creation.
 */
class StackBuffer<Element> : ManagedBuffer<Int, Element> {
  
  func copy() -> StackBuffer<Element> {
    
    func makeBuffer(elements: UnsafeMutablePointer<Element>) -> StackBuffer<Element> {
      let buffer =  StackBuffer.create(minimumCapacity: capacity) { newBuf in
        newBuf.withUnsafeMutablePointerToElements { newElements in
          newElements.initialize(from: elements, count: header)
        }
        return header
      }
      return buffer as! StackBuffer<Element>
    }
    
    return withUnsafeMutablePointerToElements { makeBuffer(elements: $0)}
  }
  
  subscript(index: Int) -> Element {
    get {
      return withUnsafeMutablePointerToElements {
        let value = $0[index]
        $0.advanced(by: index).deinitialize(count: 1)
        return value
      }
    }
    set {
      withUnsafeMutablePointerToElements {
        $0.advanced(by: index).initialize(to: newValue)
      }
    }
  }
  
  deinit {
    withUnsafeMutablePointerToElements {
      $0.deinitialize(count: header)
      return
    }
  }
}

struct Stack<Element> {
  private var _buf: StackBuffer<Element>
  
  init(capacity: Int) {
    precondition(capacity > 0)
    _buf =  StackBuffer.create(minimumCapacity: capacity) { _ in 0 } as! StackBuffer<Element>
  }
  
  var isEmpty: Bool {
    _buf.header == 0
  }
  
  var isFull: Bool {
    _buf.header == _buf.capacity
  }
  
  mutating func push(_ element: Element) {
    if !isKnownUniquelyReferenced(&_buf) {
      _buf = _buf.copy()
    }
    
    let index = _buf.header
    precondition(index != _buf.capacity)
    _buf[index] = element
    _buf.header = index + 1
  }
  
  mutating func pop() -> Element {
    if !isKnownUniquelyReferenced(&_buf) {
      _buf = _buf.copy()
    }
    
    let index = _buf.header - 1
    precondition(index >= 0)
    _buf.header = index
    return _buf[index]
  }
}

var stack = Stack<Int>(capacity: 4)

stack.isEmpty
stack.isFull

stack.push(10)
stack.push(11)

var stack2 = stack
stack2.push(12)

stack.pop()
stack.pop()

stack2.pop()
stack2.pop()
stack2.pop()
//: ## Sequences and MutableCollections contiguous storage
var numbers = [1, 2, 3, 4, 5]

let sum = numbers.withContiguousStorageIfAvailable { buffer -> Int in
  var result = 0
  for i in stride(from: buffer.startIndex, to: buffer.endIndex, by: 2) {
    result += buffer[i]
  }
  return result
}

numbers.withContiguousMutableStorageIfAvailable { buffer in
  for i in stride(from: buffer.startIndex, to: buffer.endIndex - 1, by: 2) {
    buffer.swapAt(i, i + 1)
  }
}
numbers
/*:
 ## Array initializer with access to uninitialized storage
 
 The memory in the range `buffer[0..<initializedCount]` must be initialized at
 the end of the closure’s execution, and the memory in the range
 `buffer[initializedCount...]` must be uninitialized. This postcondition must
 hold even if the initializer closure throws an error.
 */
let array = Array<Int>(unsafeUninitializedCapacity: 6) { (buffer, initializedCount) in
  buffer[0] = 0
  buffer[1] = 1
  for i in 2...5 {
    buffer[i] = buffer[i - 1] + buffer[i - 2]
  }
  initializedCount = 6
}
array
//: ## Conversion to a pointer type
func takeUnsafePointer<T>(_ pointer: UnsafePointer<T>) { }
func takeunsafeMutablePointer<T>(_ pointer: UnsafeMutablePointer<T>) { }
func takeUnsafePointerCChar(_ pointer: UnsafePointer<CChar>) { }
//: ### Explicit conversion
var explicitValue = 1
withUnsafePointer(to: explicitValue) { takeUnsafePointer($0)  }
withUnsafeMutablePointer(to: &explicitValue) { takeunsafeMutablePointer($0) }
/*:
 ### Implicit conversion
 
 A pointer that’s created by these implicit conversions is valid only for the
 duration of the function call.
 */
var value = 1
takeUnsafePointer(&value)
takeunsafeMutablePointer(&value)

var arrayValue = [1]
takeUnsafePointer(&arrayValue)
takeunsafeMutablePointer(&arrayValue)
takeUnsafePointer(arrayValue)

var stringValue = ""
takeUnsafePointerCChar(stringValue)
//: [Next](@next)
