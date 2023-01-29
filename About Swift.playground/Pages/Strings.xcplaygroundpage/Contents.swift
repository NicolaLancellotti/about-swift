//: [Previous](@previous)
//: # Strings
let stringLiteral: String = "Hello, world!"
//: ## String Interpolation
"1 + 2 = \(1 + 2)"
/*:
 ## Multiline String Literals
 The string begins on the first line after the opening quotation marks (`"""`) and ends on the line before the closing quotation marks.
 
 A multiline string can be indented to match the surrounding code. The whitespace before the closing quotation marks (""") tells Swift what whitespace to ignore before all of the other lines.
 
 When your source code includes a line break inside of a multiline string literal, that line break also appears in the string’s value. If you want to use line breaks to make your source code easier to read, but you don’t want the line breaks to be part of the string’s value, write a backslash (\) at the end of those lines.
 */
let multilineStringLiteral = """
  "Hello,\
   world!"
  1 + 2 = \(1 + 2)
  """ // ignore 2 spaces
/*:
 ## Extended String Delimiters
 
 You can place a string literal within extended delimiters to include special characters in a string without invoking their effect. You place your string within quotation marks `"` and surround that with number signs `#`.
 
 If you need the special effects of a character in a string literal, match the number of number signs within the string following the escape character `\`.
 */
##"""
\t\##t|
"\(1 + 2) = \##(1 + 2)
"""##
/*:
 ## Unicode
 
 Swift’s native String type is built from Unicode scalar values.
 
 A Unicode scalar value is a unique 21-bit number for a character or modifier.
 
 An extended grapheme cluster is a sequence of one or more Unicode scalars that (when combined) produce a single human-readable character.
 
 Every instance of Swift’s Character type represents a single extended grapheme cluster.
 */
let flag: Character = "\u{1F1EE}\u{1F1F9}"

let eGrave: Character = "\u{E8}"
let combinedEGrave: Character = "\u{65}\u{300}"

combinedEGrave.isASCII
combinedEGrave.isLetter
combinedEGrave.isCased
/*:
 ### Counting Characters
 */
let caffè1: String = "caffè"
caffè1.count

let caffè2: String = "caff\(eGrave)"
caffè2.count

let caffè3: String = "caff\(combinedEGrave)"
caffè3.count
/*:
 ### String Indices
 */
var caffè4 = "caff\(combinedEGrave)"
let index = caffè4.index(caffè4.startIndex, offsetBy: 4)
let char: Character = caffè4[index]
caffè4.insert("!", at: caffè4.endIndex)
//: ### Views
func printViews(_ string: String) {
  print("________________ Views ________________")
  print("           String: \(string)")
  print("   UnicodeScalars:", Array(string.unicodeScalars));
  print("UTF-32 code units:", string.unicodeScalars.map { $0.value });
  print("UTF-16 code units:", Array(string.utf16))
  print(" UTF-8 code units:", Array(string.utf8))
}

printViews(caffè2)
printViews(caffè3)
printViews("‼😋")
//: ### Transcode
var codeUnits: [Unicode.UTF32.CodeUnit] = []
transcode("‼😋".utf8.makeIterator(),
          from: Unicode.UTF8.self,
          to: Unicode.UTF32.self,
          stoppingOnError: false) {
  codeUnits.append($0)
}
codeUnits
//: ### Contiguous Strings
print("________________ Contiguous String ________________")
var s = "‼😋"
print("           String: \(s)")
print(" UTF-8 code units: ", terminator: "")
s.isContiguousUTF8
s.withUTF8 { buffer in
  print(Array(buffer))
}
//: ### Unicode Properties
let properties = "😋".unicodeScalars.first!.properties
properties.generalCategory
properties.isEmoji
properties.name
//: [Next](@next)
