//: [Previous](@previous)
//: # Numbers & Bool
/*:
 ## Numbers
 
 * Integers and floating-point numbers conform to the `Numeric` protocol.
 * Signed Integers and floating-point numbers conform to the `SignedNumeric` protocol.
 
 `Numeric` protocol conforms to `AdditiveArithmetic` which values  support addition and subtraction.
 */
/*:
 ## Integers
 
 Integers conform to the `FixedWidthInteger` protocol
 which inherits from the `BinaryInteger` protocol.
 
 The `FixedWidthInteger` protocol adds binary bitwise operations, bit shifts, and overflow handling to the operations supported by the BinaryInteger protocol.
 */
/*:
 ### Signed Integers
 
 Signed Integers conform to the `SignedInteger` protocol.
 * On a 32-bit platform, Int is the same size as `Int32`.
 * On a 64-bit platform, Int is the same size as `Int64`.
 */
Int.min
Int.max

Int64.min
Int64.max

Int32.min
Int32.max

Int16.min
Int16.max

Int8.min
Int8.max
/*:
 ### Unsigned Integers
 
 Unsigned Integers conform to the `UnsignedInteger` protocol.
 * On a 32-bit platform, UInt is the same size as `UInt32`.
 * On a 64-bit platform, UInt is the same size as `UInt64`.
 */
UInt.min
UInt.max

UInt64.min
UInt64.max

UInt32.min
UInt32.max

UInt16.min
UInt16.max

UInt8.min
UInt8.max
/*:
 ### Floating-Point Numbers
 
 Floating-Point Numbers conform to the `BinaryFloatingPoint` protocol
 which inherits from the `FloatingPoint` protocol.
 
 * `Float16` represents a 16-bit floating-point number.
 * `Float32` (`Float`) represents a 32-bit floating-point number.
 * `Float64` (`Double`) represents a 64-bit floating-point number.
 * `Float80` represents a 80-bit floating-point number.
 */
//: ## Bool
true
false

var boolValue = true
boolValue.toggle()
//: ## Numeric Literals
let decimalInteger =       17
let binaryInteger =      0b10001  // 17 in binary notation
let octalInteger =       0o21     // 17 in octal notation
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation

let decimalFloat = 1.25e-2    // 1.25 * 10^-2
let hexadecimalFloat = 0xFp-2 // 15 * 2^-2

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
//: ## Operators
3 + 2
3 - 2
3 * 2
3 / 2
-9 % 2

3.isMultiple(of: 2)
6.isMultiple(of: 2)
/*:
 ### Logical Operators
 
 The Swift logical operators && and || are left-associative, meaning that compound expressions with multiple logical operators evaluate the leftmost subexpression first.
 */
!true
true && false
true || false
//: ### Bitwise Operator.
let initialBits: UInt8 = 0b0000_0000

// Bitwise NOT Operator.
let notBits = ~initialBits
// Bitwise AND Operator.
let andBits = initialBits & initialBits
// Bitwise OR Operator.
let orBits = initialBits | initialBits
// Bitwise XOR Operator.
let xorBits = initialBits ^ initialBits
/*:
 ### Logical shift (Unsigned Integers)
 
 * Existing bits are moved to the left or right by the requested number of places.
 * Any bits that are moved beyond the bounds of the integer’s storage are discarded.
 * Zeros are inserted in the spaces left behind after the original bits are moved to the left or right.
 */
let shiftBits: UInt8 = 4   // 00000100 in binary
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits >> 2             // 00000001
/*:
 ### Arithmetic shift (Signed Integers)
 
 * When you shift signed integers to the right, apply the same rules as for unsigned integers, but fill any  empty bits on the left with the sign bit, rather than with a zero.
 */
let shiftBitsSigned: Int8 = -4   // 11111100 in binary
shiftBitsSigned << 1             // 11111000
shiftBitsSigned << 2             // 11110000
shiftBitsSigned >> 2             // 11111111
//: ### Overflow Operators
UInt8.max
UInt8.min
Int8.min

UInt8.max &+ 1
UInt8.min &- 1
UInt8.max &* UInt8.max

Int8.min &- 1
// etc...
//: ### Compound Assignment Operators
var a = 1.5
a += 10
a -= 6
a *= 2
a /= 2
// etc...
//: ## Functions
abs(-10.1)

//: ## Initialize with String
Int("11", radix: 10)
Int("11", radix: 2)
//: [Next](@next)
