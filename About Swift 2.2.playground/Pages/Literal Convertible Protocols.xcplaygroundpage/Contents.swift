//: [Previous](@previous)

/*:
 # Literal Convertible Protocols
 * IntegerLiteralConvertible
 * FloatLiteralConvertible
 * BooleanLiteralConvertible
 * NilLiteralConvertible
 * UnicodeScalarLiteralConvertible
 * ExtendedGraphemeClusterLiteralConvertible
 * StringLiteralConvertible
 * ArrayLiteralConvertible
 * DictionaryLiteralConvertible
 */
struct MyInt {
    var value: Int = 0
}

var myInt: MyInt
//: ## IntegerLiteralConvertible
extension MyInt: IntegerLiteralConvertible {
    
    init(integerLiteral value: Int) {
        self.value = value
    }
    
}

myInt = 1
myInt.value
//: ## NilLiteralConvertible
extension MyInt: NilLiteralConvertible {
    
    init(nilLiteral: ()) {
        self.value = 0
    }
    
}

myInt = nil
myInt.value
//: ## UnicodeScalarLiteralConvertible
extension MyInt: UnicodeScalarLiteralConvertible {
    
    init(unicodeScalarLiteral value: UnicodeScalar) {
        self.value = Int(String(value)) ?? 0
    }
    
}

myInt = "1"
myInt.value

myInt = "a"
myInt.value
//: [Next](@next)
