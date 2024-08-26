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
 * ExpressibleByStringInterpolation
 * ExpressibleByArrayLiteral
 * ExpressibleByDictionaryLiteral
 */
struct Wrapper {
  var value: Int = 0
}

var wrapper: Wrapper
/*:
 ## ExpressibleByIntegerLiteral
 
 If you need an arbitrary-precision signed integer,
 you can use `StaticBigInt` as the associated type.
 */
extension Wrapper: ExpressibleByIntegerLiteral {
  
  typealias IntegerLiteralType = Int
  
  init(integerLiteral value: Int) {
    self.value = value
  }
}

wrapper = 1
wrapper.value
//: ## ExpressibleByNilLiteral
extension Wrapper: ExpressibleByNilLiteral {
  init(nilLiteral: ()) {
    self.value = 0
  }
}

wrapper = nil
wrapper.value
//: ## ExpressibleByUnicodeScalarLiteral
extension Wrapper: ExpressibleByUnicodeScalarLiteral {
  init(unicodeScalarLiteral value: UnicodeScalar) {
    self.value = Int(String(value)) ?? 0
  }
}

wrapper = "1"
wrapper.value

wrapper = "a"
wrapper.value
//: ## ExpressibleByStringInterpolation
struct Text {
  let value: String
}

extension Text: ExpressibleByStringInterpolation {
  init(stringLiteral value: String) {
    self.value = value
  }
  
  init(stringInterpolation: StringInterpolation) {
    self.value = stringInterpolation.value
  }
  
  struct StringInterpolation: StringInterpolationProtocol {
    var value: String = ""
    
    init(literalCapacity: Int, interpolationCount: Int) {
      self.value.reserveCapacity(literalCapacity)
    }
    
    mutating func appendLiteral(_ literal: String) {
      self.value.append(literal)
    }
    
    mutating func appendInterpolation<T>(_ value: T) where T: CustomStringConvertible {
      self.value.append(value.description)
    }
    
    mutating func appendInterpolation<T>(_ value: T, reversed: Bool) where T: CustomStringConvertible {
      if reversed {
        self.value.append(String(value.description.reversed()))
      } else {
        self.value.append(value.description)
      }
    }
  }
}

let text = "oaic reversed: \("oaic", reversed: true)" as Text
text.value
//: ### DefaultStringInterpolation
extension DefaultStringInterpolation {
  mutating func appendInterpolation(_ value: Date, formatter: DateFormatter) {
    self.appendInterpolation(formatter.string(from: value))
  }
}

import Foundation
let dateFormatter = DateFormatter()
dateFormatter.timeStyle = .medium
let now = Date()
"time: \(now, formatter: dateFormatter)"
//: [Next](@next)
