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
intArray.initialize(to: 10, count: 3)
//intArray.initialize(from: [10, 10, 10])

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
 { defer { deinitialize() }; return pointee }()
 but more efficient.
 */
intArray.move()

//: ### Deinitialize
intArray.deinitialize(count: 3)
//: ### Deallocate
intArray.deallocate(capacity: 3)
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
p.initialize(to: SomeStruct(someClass: SomeClass()),
             count: 1)

p.deinitialize(count: 1) // print "deinit SomeClass" in the console
p.deallocate(capacity: 1)
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
                                            capacity: 1) {
                                                return $0.pointee.foo()
}

/*:
 ## Pointers for untyped data
 * UnsafeMutableRawPointer - mutating pointer
 * UnsafeRawPointer - non mutating pointer
 */

//: [Next](@next)
