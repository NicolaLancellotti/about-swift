//: [Previous](@previous)

//: # Numbers

/*:
 ## Int
 * On a 32-bit platform, Int is the same size as Int32.
 * On a 64-bit platform, Int is the same size as Int64.
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
 ## UInt
 * On a 32-bit platform, UInt is the same size as UInt32.
 * On a 64-bit platform, UInt is the same size as UInt64.
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
 ## Floating-Point Numbers
 
 * Double represents a 64-bit floating-point number.
 * Float represents a 32-bit floating-point number.
 */

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

//: ## Absolute Value
abs(-10.1)
//: ## Initialize with String
Int("11", radix: 10)
Int("11", radix: 2)
//: [Next](@next)
