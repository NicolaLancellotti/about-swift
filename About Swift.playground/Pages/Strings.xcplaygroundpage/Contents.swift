//: [Previous](@previous)
import Foundation
//: # Strings
let emptyString = String()
let anotherEmptyString = ""

let someString = "Some string literal value"
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
//: ## String Interpolation
let apples = 4
print("There are \(apples) apples")
/*:
 ## Unicode
 Character  represents a single extended grapheme cluster. (sequence of one or more Unicode scalars)
 */
let sparklingHeart = "\u{1F496}"

let eAcute: Character = "\u{E9}"
let combinedEAcute: Character = "\u{65}\u{301}"

let regionalIndicatorForIT: Character = "\u{1F1EE}\u{1F1F9}"
//: Counting Characters
var word = "cafe"
word.characters.count
word.utf16.count
(word as NSString).length //UTF-16

word += "\u{301}" // acute accent
word.characters.count
word.utf16.count
(word as NSString).length //UTF-16
/*:
 ## String Indices
 Swift strings cannot be indexed by integer values.
 */
word[word.index(word.startIndex, offsetBy: 3)]

for index in word.characters.indices {
    print("\(word[index]) ", terminator: "")
}
print("")

word.insert("!", at: word.endIndex)

//: ## Views
let dogString = "Dog‼🐶🇮🇳"
print("________________ Views ________________")
print("        string: ", dogString);
print("    characters: ", Array(dogString.characters))
print("          utf8: ", Array(dogString.utf8))
print("         utf16: ", Array(dogString.utf16))


// 21-bit // equivalent to a UTF-32 code unit.
print("UnicodeScalars: ", Array(dogString.unicodeScalars));
print("Numeric values: ", dogString.unicodeScalars.map { $0.value });

var codeUnits: [UTF32.CodeUnit] = []
transcode(dogString.utf8.makeIterator(), from: UTF8.self, to: UTF32.self, stoppingOnError: false) {
    codeUnits.append($0)
}
print("Numeric values: ", codeUnits);
//: ## Multiline String Literals
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
//: Line break
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
//: Intendation
let linesWithIndentation = """
    ABCD
        abcd
    """
//: [Next](@next)
