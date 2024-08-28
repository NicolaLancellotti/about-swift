//: [Previous](@previous)
/*:
 # Regex
 */
/*:
 ## Regex literals
 A regex literal may not start or end with a space or tab.
 */
do {
  let regex = /(\w)-(?<number>\d)/
  
  if let match = "a-1".wholeMatch(of: regex) {
    match.0
    
    // First capture
    match.1 // typed capture
    
    // Second capture
    match.2
    match.number // named capture
  }
}
/*:
 ### Extended literals
 An extended literal, `#/.../#`, `##/.../##`, etc. avoids the need to escape
 forward slashes within the regex.
 */
do {
  let regex = #/ a/b/#
  
  if let match = " a/b".wholeMatch(of: regex) {
    match.0
  }
}
//: Escaping of backslashes
"\n"   // string of one character: the new line character
"\\n"  // string of two characters: "\" and "n"
#"\n"# // string of two characters: "\" and "n"
#/\n/# // regex that match new the line character
/*:
 ### Multi-line literals
 In a multi-line literal whitespace is non-semantic and line-ending comments are
 ignored.
 
 Newlines may be written using `\n`, or by using a backslash to escape the
 literal newline character.
 
 In such a literal, extended regex syntax `(?x)` is enabled and it may not be
 disabled with `(?-x)`,
 however it may be disabled for the contents of a group `(?-x:...)`
 or quoted sequence `\Q...\E`, as long as they do not span multiple line.
 */
do {
  let regex = #/
  (?<number>\d) # a comment
  \n
  a\
  /#
  
  if let match = "0\na\n".wholeMatch(of: regex) {
    match.0
    match.number
  }
}
//: ## Run-time construction
do {
  let pattern = #"(\w)-(?<number>\d)"#
  
  let regex1: Regex<AnyRegexOutput> = try! Regex(pattern)
  if let match = "a-1".wholeMatch(of: regex1) {
    match.0
    match[1].value
    match["number"]?.value
  }
  
  let regex2 = try! Regex(pattern, as: (Substring, Substring, number: Substring).self)
  if let match = "a-1".wholeMatch(of: regex2) {
    match.0
    match.1
    match.number
  }
}
//: ## Regex algorithms
do {
  let string = "abca"
  let regex = /a/
  string.contains(regex)
  string.starts(with: regex)
  string.trimmingPrefix(regex)
  string.firstRange(of: regex)
  string.ranges(of:regex)
  string.replacing(regex, with: "A")
  string.split(separator: /[b]/)
  string.firstMatch(of: regex)?.0
  string.wholeMatch(of: /abca/)?.0
  string.prefixMatch(of: regex)?.0
  string.matches(of: regex).count
}
/*:
 ## Regex builder DSL
 
 All types that can represent a component of a regex conform to `RegexComponent`.
 */
import RegexBuilder
/*:
 `RegexComponentBuilder` is a result builder type for composing regexes by
 concatenation.
 
 ```
 extension Regex {
   public init<Content>(@RegexComponentBuilder _ content: () -> Content)
     where Output == Content.RegexOutput, Content : RegexComponent
 }
 ```
 */
do {
  let regex = Regex {
    /\d/ // Regex conforms to RegexComponent
    "a"  // String conforms to RegexComponent
  }
  
  "1a".wholeMatch(of: regex)?.0
}
//: ### CharacterClass
Regex {
  CharacterClass.any // single-line mode: /(?s:.)/
  CharacterClass.anyNonNewline // single-line mode disabled: /(?-s:.)/
  CharacterClass.anyGraphemeCluster // /\X/
  
  CharacterClass.digit // /\d/
  CharacterClass.digit.inverted // /\D/
  CharacterClass.hexDigit // /\p{Hex_Digit}/
  
  CharacterClass.word // /\w/
  CharacterClass.word.inverted // /\W/
  
  CharacterClass.whitespace // /\s/
  CharacterClass.whitespace.inverted // /\S/
  CharacterClass.horizontalWhitespace  // /\h/
  CharacterClass.horizontalWhitespace.inverted  // /\H/
  CharacterClass.verticalWhitespace  // /\v/
  CharacterClass.verticalWhitespace.inverted  // /\V/
  CharacterClass.newlineSequence // /\R/
  CharacterClass(.digit, "a"..."c", .anyOf("de")) // /[\d[a-c]de]/
  CharacterClass("a"..."d").subtracting(.anyOf("b")) // /[a-d--b]/
  
  // Unicode property classes
  CharacterClass.generalCategory(.currencySymbol)
}
/*:
 ### Alternations
 `AlternationBuilder` is a result builder type for creating alternations from
 components of a block.
 ```
 public struct ChoiceOf<Output> {
   public init(@AlternationBuilder _ builder: () -> ChoiceOf<Output>)
   ...
 }
 ```
 */
do {
  let regex = Regex {
    ChoiceOf {
      "a"
      "b"
    }
  }
  
  "a".wholeMatch(of: regex)?.0
  "c".wholeMatch(of: regex)
}
/*:
 ### Repetitions
 Repetition behavior:
 - `.eager`: (default) match as much of the input string as possible,
 backtracking when necessary.
 - `.reluctant`: match as little of the input string as possible, expanding the
 matched region as necessary to complete a match.
 - `.possessive`: match as much of the input string as possible, performing no
 backtracking.
 */
Regex {
  One("a")
  OneOrMore("a")
  ZeroOrMore("a")
  Optionally("a")
  Repeat("a", count: 2)
  Repeat("a", 2...)
  Repeat("a", 2...4)
  OneOrMore("a", .possessive)
}
//: ### Anchors
Regex {
  Anchor.startOfSubject // /\A/
  Anchor.endOfSubjectBeforeNewline // /\Z/
  Anchor.endOfSubject // /\z/
  Anchor.firstMatchingPositionInSubject // /\G/
  Anchor.textSegmentBoundary // /\y/
  Anchor.startOfLine // /(?m:^)/
  Anchor.endOfLine // /(?m:$)/
  Anchor.wordBoundary // /\b/
  Anchor.wordBoundary.inverted // /\B/
}
/*:
 ### Lookaheads
 - `Lookahead`: a regex component that allows a match to continue only if its
 contents match at the given location.
 - `NegativeLookahead`: a regex component that allows a match to continue only
 if its contents do not match at the given location.
 */
do {
  let regex = Regex {
    "0"
    Lookahead {
      "a"
    }
  }
  
  "0a".firstMatch(of: regex)?.0
  "0b".firstMatch(of: regex)
}

do {
  let regex = Regex {
    "0"
    NegativeLookahead {
      "a"
    }
  }
  
  "0a".firstMatch(of: regex)
  "0b".firstMatch(of: regex)?.0
}
/*:
 ### Scoping
 This group opens a local backtracking scope which, upon successful exit,
 discards any remaining backtracking points from within the scope.
 */
do {
  let regex = Regex {
    Local {
      Optionally("a")
    }
    "ab"
  }
  
  "aab".wholeMatch(of: regex)?.0
  "ab".wholeMatch(of: regex)
}
//: ### Subpatterns
do {
  let regex = Regex {
    let aOrB = ChoiceOf {
      "a"
      "b"
    }
    aOrB
    "-"
    aOrB
  }
  
  "a-b".wholeMatch(of: regex)?.0
  "b-a".wholeMatch(of: regex)?.0
}
/*:
 ### Captures
 - `Capture`: when a transform closure throws during matching, the matching will
 abort and the error will be propagated directly to the top-level matching API
 that's being called.
 - `TryCapture`: when a transform closure returns nil, the regex engine
 backtracks and tries an alternative.
 */
do {
  enum Value: String {
    case a
    case b
  }
  
  let regex = Regex {
    let aOrB = ChoiceOf {
      "a"
      "b"
    }
    
    Capture {
      aOrB
    }
    
    Capture {
      aOrB
    } transform: {
      "letter \($0)"
    }
    
    TryCapture {
      aOrB
    } transform: {
      Value(rawValue: String($0))
    }
  }
  
  if let match = "aba".wholeMatch(of: regex) {
    match.1
    match.2
    match.3
  }
}
//: ### References
do {
  let reference = Reference(Int.self)
  
  let regex = Regex {
    TryCapture(as: reference) {
      ChoiceOf {
        "0"
        "1"
      }
    } transform: {
      Int($0)
    }
  }
  
  if let match = "1".wholeMatch(of: regex) {
    match[reference]
  }
}
/*:
 ### CustomConsumingRegexComponent
 
 `CustomConsumingRegexComponent` protocol allows types from outside the standard
 library to participate in regex builders and `RegexComponent` algorithms.
 */
import Foundation

do  {
  let format: Date.FormatString = 
    "\(day: .twoDigits)/\(month: .twoDigits)/\(year: .padded(4))"
  let timeZone = TimeZone(identifier: "UTC")!
  let locale = Locale(identifier: "en-UK")
  
  let regex = Regex {
    // Date.ParseStrategy implements CustomConsumingRegexComponent
    Capture(Date.ParseStrategy(format: format,
                               locale: locale,
                               timeZone: timeZone))
    "-"
    // RegexComponent has a `date` method too
    Capture(.date(format: format, locale: locale, timeZone: timeZone))
  }
  
  if let match = "31/12/1999-01/01/2000".wholeMatch(of: regex) {
    match.1
    match.2
  }
}
//: ## Options
/*:
 ### Case insensitivity
 Regex syntax: `(?i)...`
 */
do {
  let regex1 = Regex {
    "a"
    Regex { "b" }.ignoresCase(false)
  }.ignoresCase()
  
  let regex2 = /(?i)a(?-i:b)/
  
  let string = "Ab"
  string.contains(regex1)
  string.contains(regex2)
}
/*:
 ### ASCII-only character classes
 Regex syntax: `(?DSWP)...`
 - Regex syntax `(?D)`: Match only ASCII members for `\d`, `[:digit:]`, and
 `CharacterClass.digit`.
 - Regex syntax `(?S)`: Match only ASCII members for `\s`, `[:space:]`, and any
 of the whitespace-representing `CharacterClass` members.
 - Regex syntax `(?W)`: Match only ASCII members for `\w`, `[:word:]`, and
 `CharacterClass.word`. Also only considers ASCII characters for `\b`, `\B`,
 and `Anchor.wordBoundary`.
 - Regex syntax `(?P)`: Match only ASCII members for all POSIX properties
 (including `digit`, `space`, and `word`).
 */
do {
  let regex1 = Regex {
    CharacterClass.digit
  }.asciiOnlyDigits()
  
  let regex2 = /(?D)\d/
  
  let string = "१"
  string.contains(regex1)
  string.contains(regex2)
}
/*:
 ### Simple word boundaries
 Regex syntax (disable Unicode default word boundaries): `(?-w)...`
 */
do {
  let regex1 = Regex {
    CharacterClass.any
    Anchor.wordBoundary
  }.wordBoundaryKind(.simple)
  
  //    /(?-w).\b/ //  unsupported
  let regex2 = /.\b/.wordBoundaryKind(.simple)
  
  let string = "don't"
  string.firstMatch(of: regex1)!.0
  string.firstMatch(of: regex2)!.0
}
/*:
 ### Matching semantic level
 */
do {
  let string = "Cafe\u{301}"
  string.contains(/Café/)
  string.contains(/Café/.matchingSemantics(.unicodeScalar))
  string.contains(/Cafe\u{301}/.matchingSemantics(.unicodeScalar))
}
/*:
 ### Single line mode (. matches newlines)
 Regex syntax: `(?s)...`
 
 This option applies only to `.` used in regex syntax and does not affect the
 behavior of `CharacterClass.any`, which always matches any character or
 Unicode scalar. To get the default `.` behavior when using `RegexBuilder`
 syntax, use `CharacterClass.anyNonNewline`.
 */
do {
  let regex1 = /.+/.dotMatchesNewlines()
  let regex2 = /(?s).+/
  
  let string = """
      a
      b
      """
  string.wholeMatch(of: regex1)!.0
  string.wholeMatch(of: regex2)!.0
}
/*:
 ### Multiline mode
 By default, the start and end anchors (`^` and `$`) match only the beginning
 and end of a string. In multiline mode, they also match the beginning and end
 of each line.
 
 Regex syntax: `(?m)...`
 
 This option applies only to anchors used in regex syntax. The anchors defined
 in `RegexBuilder` are specific about matching at the start/end of the input or
 the line, and therefore are not affected by this option.
 */
do {
  let regex1 = /^b$/.anchorsMatchLineEndings()
  let regex2 = /(?m)^b$/
  
  let string = """
      a
      b
      """
  string.firstMatch(of: regex1)!.0
  string.firstMatch(of: regex2)!.0
}
/*:
 ### Default repetition behavior
 */
do {
  let regex = Regex {
    One("<")
    OneOrMore(.any)
    One(">")
  }
  
  let string = "<a> <b>"
  string.firstMatch(of: regex.repetitionBehavior(.eager))!.0
  string.firstMatch(of: regex.repetitionBehavior(.reluctant))!.0
  string.firstMatch(of: regex.repetitionBehavior(.possessive))
}
/*:
 ### Eager/reluctant toggle
 
 Regex quantifiers (`+`, `*`, and `?`) match eagerly by default when they
 repeat, such that they match the longest possible substring. Appending `?` to a
 quantifier makes it reluctant, instead, so that it matches the shortest
 possible substring.
 
 Regex syntax: `(?U)...`
 
 The `U` option toggles the "eagerness" of quantifiers, so that quantifiers are
 reluctant by default, and only become eager when `?` is added to the
 quantifier.
 
 This change only applies within regex syntax.
 */
do {
  let regexReluctant = /(?U)<.+>/
  let regexEager = /(?U)<.+?>/
  
  let string = "<a> <b>"
  string.firstMatch(of: regexReluctant)!.0
  string.firstMatch(of: regexEager)!.0
}
//: [Next](@next)
