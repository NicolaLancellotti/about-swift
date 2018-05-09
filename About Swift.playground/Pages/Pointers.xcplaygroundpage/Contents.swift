//: [Previous](@previous)

//: # Pointers

/*:
 ## Pointers for typed data
 * UnsafeMutablePointer - mutating pointer
 * UnsafePointer - non mutating pointer
 */

//: ### Allocate
let intArray = UnsafeMutablePointer<Int>.allocate(capacity: 3)
//: ### Initialize
intArray.initialize(repeating: 10, count: 3)
/*:
 - note:
 You can use `assign` and `moveAssign` methods to assign pointees of another pointer.
 */

//: ### Work
intArray[0]
intArray[1]
intArray[2]

intArray.pointee
intArray.successor().pointee
intArray.successor().successor().pointee

intArray.advanced(by: 0).pointee
intArray.advanced(by: 1).pointee
intArray.advanced(by: 2).pointee

intArray.distance(to: intArray.successor())

/*
 Equivalent to
 { defer { p.deinitialize(count: 1) }; return pointee }()
 but more efficient.
 */
intArray.move()

//: ### Deinitialize
intArray.deinitialize(count: 3)
//: ### Deallocate
intArray.deallocate()
//: ### Example Deinitialize
class SomeClass {
    deinit {
        print("deinit SomeClass")
    }
}

struct SomeStruct {
    var someClass: SomeClass
    
    init(someClass: SomeClass) {
        self.someClass = someClass
    }
    
}

let p = UnsafeMutablePointer<SomeStruct>.allocate(capacity: 1)
p.initialize(repeating: SomeStruct(someClass: SomeClass()),
             count: 1)

p.deinitialize(count: 1) // print "deinit SomeClass" in the console
p.deallocate()
//: ### Rebinds memory
struct BaseStruct {
    var stringValue: String
    
    func foo() -> String {
        return stringValue
    }
}

struct SubStruct {
    var stringValue: String
    var intValue: Int
}

var subStruct = SubStruct(stringValue: "Hello", intValue: 1)
let subStructP = UnsafeMutablePointer(&subStruct)

let fooValue = subStructP.withMemoryRebound(to: BaseStruct.self,
                                            capacity: 1)
{
    return $0.pointee.foo()
}

/*:
 ## Pointers for untyped data
 * UnsafeMutableRawPointer - mutating pointer
 * UnsafeRawPointer - non mutating pointer
 */

/*:
 ## Buffer Pointers
 
 A non-owning pointer to a buffer of elements
 stored contiguously in memory, presenting a collection interface to the underlying elements.
 
 * UnsafeMutableBufferPointer - for mutating elements
 * UnsafeBufferPointer - for non mutating elements
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

/*:
 ## Managed Buffer
 
 A class whose instances contain a property of type Header and raw storage for an array of Element, whose size is determined at instance creation.
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
        return _buf.header == 0
    }
    
    var isFull: Bool {
        return _buf.header == _buf.capacity
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
//: [Next](@next)
