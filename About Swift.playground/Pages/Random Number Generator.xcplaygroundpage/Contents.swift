//: [Previous](@previous)

//: # Random Number Generator
Bool.random()
Int.random(in: 0...10)
UInt.random(in: 0...10)
Float.random(in: 0...10)

[1, 2, 3].randomElement()
[1, 2, 3].shuffled()
/*:
 RNGs conform to RandomNumberGenerator
 
 SystemRandomNumberGenerator is the generator used by default
 */
var rng = SystemRandomNumberGenerator()
Int.random(in: 0...10, using: &rng)
//: [Next](@next)
