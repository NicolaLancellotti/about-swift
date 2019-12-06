//: [Previous](@previous)

//: # SIMD

//: ## Initialization
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
//: ##  Properties & Subscripts
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
//: ##  Operations

//: ###  Pointwise Operators
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
//: ### Bitwise Operators
do {
  let simd = SIMD2(3, 2)
  ~simd
  simd & 3
  simd | 4
  simd ^ 2
}

//: ##  Methods & Functions
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
//: [Next](@next)
