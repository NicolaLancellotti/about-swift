//: [Previous](@previous)

/*:
 # Expressible By Protocols
 * ExpressibleByIntegerLiteral
 * ExpressibleByFloatLiteral
 * ExpressibleByBooleanLiteral
 * ExpressibleByNilLiteral
 * ExpressibleByUnicodeScalarLiteral
 * ExpressibleByExtendedGraphemeClusterLiteral
 * ExpressibleByStringLiteral
 * ExpressibleByArrayLiteral
 * ExpressibleByDictionaryLiteral
 */
struct MyInt {
    var value: Int = 0
}

var myInt: MyInt
//: ## ExpressibleByIntegerLiteral
extension MyInt: ExpressibleByIntegerLiteral {
    
    init(integerLiteral value: Int) {
        self.value = value
    }
    
}

myInt = 1
myInt.value
//: ## ExpressibleByNilLiteral
extension MyInt: ExpressibleByNilLiteral {
    
    init(nilLiteral: ()) {
        self.value = 0
    }
    
}

myInt = nil
myInt.value
//: ## ExpressibleByUnicodeScalarLiteral
extension MyInt: ExpressibleByUnicodeScalarLiteral {
    
    init(unicodeScalarLiteral value: UnicodeScalar) {
        self.value = Int(String(value)) ?? 0
    }
    
}

myInt = "1"
myInt.value

myInt = "a"
myInt.value
//: [Next](@next)
