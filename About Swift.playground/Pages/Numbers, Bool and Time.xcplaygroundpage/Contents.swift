//: [Previous](@previous)
//: # Numbers, Bool and Time
/*:
 ## Numeric Protocols
 Indentation represents protocol inheritance.
 - `AdditiveArithmetic` (addition and subtraction)
    - `Numeric` (multiplication)
        - `SignedNumeric` (negation)
            - `FloatingPoint` (floating-point numeric type)
                - `BinaryFloatingPoint` (binary floating-point type)
        - `BinaryInteger` (binary integer type)
            - `SignedInteger` (integer type that can represent both positive and negative values)
            - `UnsignedInteger` (integer type that can represent only nonnegative values)
            - `FixedWidthInteger` (binary integer type with fixed size)
 */
/*:
 ## Numbers
 */
/*:
 ### Signed integers
 * On a 32-bit platform, `Int` is the same size as `Int32`.
 * On a 64-bit platform, `Int` is the same size as `Int64`.
 */
Int.min
Int.max

Int128.max
Int128.min

Int64.min
Int64.max

Int32.min
Int32.max

Int16.min
Int16.max

Int8.min
Int8.max
/*:
 ### Unsigned integers
 * On a 32-bit platform, `UInt` is the same size as `UInt32`.
 * On a 64-bit platform, `UInt` is the same size as `UInt64`.
 */
UInt.min
UInt.max

UInt128.max
UInt128.min

UInt64.min
UInt64.max

UInt32.min
UInt32.max

UInt16.min
UInt16.max

UInt8.min
UInt8.max
/*:
 ### Floating-point numbers
 * `Float16` represents a 16-bit floating-point number.
 * `Float32` (`Float`) represents a 32-bit floating-point number.
 * `Float64` (`Double`) represents a 64-bit floating-point number.
 * `Float80` represents a 80-bit floating-point number.
 */
//: ### Numeric literals
let paddedDecimalInteger = 033_071
String(paddedDecimalInteger, radix: 2)

// Each octal digit corresponds to log2(8) = 3 binary digits
var binaryInteger = 0b1_000_000_100_101_111
let octalInteger = 0o100457

// Each hexadecimal digit corresponds to log2(16) = 4 binary digits
binaryInteger = 0b1000_0001_0010_1111
let hexadecimalInteger = 0x812f

let decimalFloat = 1.25e-2    // 1.25 * 10^(-2)
let hexadecimalFloat = 0xfp-2 // 15 * 2^-2
//: ### Operators
3 + 2
3 - 2
3 * 2
3 / 2
-9 % 2

3.isMultiple(of: 2)
6.isMultiple(of: 2)
/*:
 ### Logical operators
 
 The Swift logical operators `&&` and `||` are left-associative, meaning that
 compound expressions with multiple logical operators evaluate the leftmost
 subexpression first.
 */
!true
true && false
true || false
//: ### Bitwise operators
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
 ### Logical shift (unsigned integers)
 
 * Existing bits are moved to the left or right by the requested number of
 places.
 * Any bits that are moved beyond the bounds of the integer’s storage are
 discarded.
 * Zeros are inserted in the spaces left behind after the original bits are
 moved
 to the left or right.
 */
let shiftBits: UInt8 = 4   // 00000100 in binary
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits >> 2             // 00000001
/*:
 ### Arithmetic shift (signed integers)
 
 * When you shift signed integers to the right, apply the same rules as for
 unsigned integers, but fill any empty bits on the left with the sign bit,
 rather than with a zero.
 */
let shiftBitsSigned: Int8 = -4   // 11111100 in binary
shiftBitsSigned << 1             // 11111000
shiftBitsSigned << 2             // 11110000
shiftBitsSigned >> 2             // 11111111
//: ### Overflow operators
UInt8.max
UInt8.min
Int8.min

UInt8.max &+ 1
UInt8.min &- 1
UInt8.max &* UInt8.max

Int8.min &- 1
// etc...
//: ### Compound assignment operators
var a = 1.5
a += 10
a -= 6
a *= 2
a /= 2
// etc...
//: ### Functions
abs(-10.1)
//: ### Initialize with string
Int("11", radix: 10)
Int("11", radix: 2)
//: ## Bool
true
false

var boolValue = true
boolValue.toggle()
//: ## Random number generators
Bool.random()
Int.random(in: 0...10)
UInt.random(in: 0...10)
Float.random(in: 0...10)

[1, 2, 3].randomElement()
[1, 2, 3].shuffled()
/*:
 RNGs conform to `RandomNumberGenerator`.
 
 `SystemRandomNumberGenerator` is the generator used by default.
 */
var rng = SystemRandomNumberGenerator()
Int.random(in: 0...10, using: &rng)
//: ## SIMD
//: ### Initialization
SIMD2<Int>()
SIMD3<Int>()
SIMD4<Int>()
SIMD8<Int>()
SIMD16<Int>()
SIMD32<Int>()
SIMD64<Int>()

SIMD2<Int>.zero
SIMD2<Int>.one

SIMD2(repeating: 2)
SIMD2(1, 2)
SIMD2([1, 2])
SIMD3<Int8>(SIMD2(1, 2), 3)
SIMD4<Int>(lowHalf: SIMD2.one, highHalf: SIMD2.zero)

SIMD2<Int8>(clamping: SIMD2(Int.max, 2))
SIMD2.random(in: 1...10)
//: ### Properties & subscripts
do {
  let simd = SIMD4<Int8>(1, 2, 3, 4)
  simd[0]
  simd.x
  simd.y
  simd.z
  simd.w
  
  let zyx = SIMD3(2, 1, 0)
  simd[zyx]
  
  simd.trailingZeroBitCount
  simd.leadingZeroBitCount
  simd.nonzeroBitCount
  simd.scalarCount
  simd.lowHalf
  simd.highHalf
}
//: ### Operations
//: Pointwise operators
do {
  let simd1 = SIMD2(4.0, 2.0)
  let simd2 = SIMD2(repeating: 2.0)
  
  simd1 .== simd2
  simd1 .!= simd2
  simd1 .< simd2
  simd1 .<= simd2
  simd1 .> simd2
  simd1 .>= simd2
  
  // FloatingPoint
  simd1 + simd2
  simd1 - simd2
  simd1 * simd2
  simd1 / simd2
  simd1.squareRoot()
  simd1.addingProduct(3, SIMD2(5.0, 5.0)) // (3 * 5 + 4, 3 * 5 + 2)
  
  // FixedWidthInteger (Overflow Operators)
  let simdInt = SIMD2<UInt8>(3, 2)
  simdInt &+ 1
  simdInt &- 3
  simdInt &* 4
  simdInt &<< 1
  simdInt &>> 1
  simdInt / 2
  simdInt % 2
}
//: Bitwise operators
do {
  let simd = SIMD2(3, 2)
  ~simd
  simd & 3
  simd | 4
  simd ^ 2
}
//: ### Methods & functions
do {
  let simd = SIMD3<Int8>(2, 4, 6)
  simd.max()
  simd.min()
  simd.wrappedSum()
  simd.replacing(with: 0, where: .init([true, false, false]))
  
  simd.clamped(lowerBound: SIMD3(repeating: 3),
               upperBound: SIMD3(repeating: 5))
  
  SIMD2(-4.1, 25.3).rounded(.towardZero)
  
  simd == simd
  simd != simd
  
  pointwiseMin(SIMD2(2, 4), SIMD2(1, 3))
  pointwiseMax(SIMD2(2, 4), SIMD2(1, 3))
  
  any(simd .== 2)
  all(simd .== 2)
}
/*:
 ## Time
 - `ContinuousClock`: a clock that measures time that always increments but does
 not stop incrementing while the system is asleep.
 - `SuspendingClock`: a clock that measures time that always increments but
 stops incrementing while the system is asleep.
 */

let clock = ContinuousClock()
let now: ContinuousClock.Instant = clock.now
let minimumResolution: Duration = clock.minimumResolution

let duration: Duration = clock.measure {
  for _ in 0...100 {
    
  }
}
duration.components
//: [Next](@next)
