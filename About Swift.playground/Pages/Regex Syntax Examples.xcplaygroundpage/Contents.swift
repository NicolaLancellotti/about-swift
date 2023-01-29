//: [Previous](@previous)
/*:
 # Regex Syntax Examples
 The syntax is a superset of the following regular expression engines:
 - PCRE 2
 - Oniguruma
 - ICU
 - .NET
 */
//: ## Top-level
#/
a | b   # Alternation
abc|def # Concatenation
/#
//: ## Concatenated subexpressions
#/
(?# a comment)
\Q[a-b]\E  # Quote, it matches `[a-b]`
/#
//: ## Quantified subexpressions
#/
\d?     # 0 or 1 times
\d*     # 0 or more times
\d+     # 1 or more times
\d{2,4} # Between 2 and 4 (inclusive) times
\d{2,}  # 2 or more times
\d{,4}  # Up to 4 times
\d{2}   # Exactly 2 times

\d*     # Eager
\d*?    # Reluctant
\d*+    # Possessive
/#
//: ## Anchors
#/
^   # Matches at the very start of the input string, or the start of a line when
    # in multi-line mode
$   # Matches at the very end of the input string, or the end of a line when in
    # multi-line mode
\A  # Matches at the very start of the input string
\Z  # Matches at the very end of the input string, in addition to before a
    # newline at the very end of the input string
\z  # Like \Z, but only matches at the very end of the input string
\G  # Like \A, but also matches against the start position of where matching
    # resumes in global matching mode (e.g \Gab matches twice in abab, \Aab
    # would only match once)
# \c <Char>: A control character sequence, which denotes a scalar
    # from U+00 - U+7F depending on the ASCII character provided
\b  # Matches a boundary between a word character and a non-word character
\B  # Matches a non-word-boundary
\y  # Matches a text segment boundary, the definition of which varies based on
    # the y{w} and y{g} matching option
\Y  # Matches a non-text-segment-boundary
/#
//: ## Escape sequences
#/
\a    # The alert (bell) character U+7
\b    # The backspace character U+8. Note this may only be used in a custom
      # character class, otherwise it represents a word boundary
\e    # The escape character U+1B
\f    # The form-feed character U+C
\n    # The newline character U+A
\r    # The carriage return character U+D
\t    # The tab character U+9
/#
//: ## Builtin character classes
#/
.     # Any character excluding newlines
# \C  # A single UTF code unit
\d    # Digit character
\D    # Non-digit character
\h    # Horizontal space character
\H    # Non-horizontal-space character
# \N  # Non-newline character
# \O  # Any character (including newlines)
\R    # Newline sequence
\s    # Whitespace character
\S    # Non-whitespace character
\v    # Vertical space character
\V    # Non-vertical-space character
\w    # Word character
\W    # Non-word character
\X    # Any extended grapheme cluster
/#
//: ## Unicode scalars
#/
\u{41}      # Matches `A`
\u{41 42}   # Same as \u{41}\u{42}}

\u0041                     # Same as \u{41}
\x41                       # Same as \u{41}
\x{41}                     # Same as \u{41}
\U00000041                 # Same as \u{41}
\o{101}                    # Same as \u{41}
\0101                      # Same as \u{41}
\N{U+41}                   # Same as \u{41}
\N{LATIN CAPITAL LETTER A} # Same as \u{41}

\x          # Matches the NUL character (U+00)
/#
//: ## Character properties
//: ### The full range of Unicode character properties
#/
\p{generalCategory=uppercaseLetter}
\p{uppercaseLetter}

\p{Lowercase=True}
\p{Lowercase}

\p{Script_Extensions=Greek}
\p{Greek}

# \p{Block=Basic_Latin}
# \p{inBasicLatin}
/#
//: ### POSIX
#/
\p{alnum}
\p{blank}
\p{graph}
\p{print}
\p{word}
\p{xdigit}
/#
//: ### UTS#18
#/
\p{any}
\p{assigned}
\p{ascii}
/#
//: ### POSIX-style
#/
[:generalCategory=uppercaseLetter:]
/#
//: ### Unimplemented
#/
# PCRE2
# \p{Xan}
# \p{Xps}
# \p{Xsp}
# \p{Xuc}
# \p{Xwd}

# Java
# \p{javaLowerCase}
# \p{javaUpperCase}
# \p{javaWhitespace}
# \p{javaMirrored}
/#
/*:
 ## `\K`
 
 The \K escape sequence is used to drop any previously matched characters from
 the final matching result.
 */
#/
# a(b)\Kc # when matching against `abc` will return a match of `c`,
          # but with a capture of `b`
/#
//: ## Groups
//: ### Basic group kinds
#/
(\d)            # A capturing group

(?<number1>\d)  # A named capturing group
(?'number2'\d)
(?P<number3>\d)

(?:\d)          # A non-capturing group
/#
/*:
 ### Atomic group
 It specifies that its contents should not be re-evaluated for backtracking.
 */
#/
(?>\d)
(*atomic:\d)
/#
//: ### Lookahead and lookbehind
#/
# Atomic Lookahead
(?=\d)
(*positive_lookahead:\d)
(*pla:\d)

# Atomic Negative Lookahead
(?!\d)
(*negative_lookahead:\d)

# Atomic Lookbehind
# (?<=\d)
# (*positive_lookbehind:\d)

# Atomic Negative Lookbehind
# (?<!\d)
# (*negative_lookbehind:\d)

# Non-atomic Lookahead
# (?*\d)
# (*non_atomic_positive_lookahead:\d)

# Non-atomic Lookbehind
# (?<*\d)
# (*non_atomic_positive_lookbehind:\d)
/#
//: ### Unimplemented
#/
# Script runs
# It specifies that the contents must match against a sequence of characters
# from the same Unicode script
# (*script_run:\w)
# (*atomic_script_run:\w)

# Balancing groups
# (?<currentGroup-number1>\d)

# Branch reset groups
#(?|(\d)|(\w))
/#
/*:
 ## Custom character classes
 Operators:
 - `&&`: intersection
 - `--`: subtraction
 - `~~`: symmetric difference
 */
#/
[\d[a-c]d] # Matches `a`, `b`, `c`, `d` and digit characters
[a\Q]\E]   # Matches `a` and `]`
[a-d--b]   # Matches `a`, `c`, `d`
/#
//: ## Matching options
#/
# PCRE options
(?i)    # Case insensitivity
(?m)    # Multiline mode (`^` and `$` match beginning and end of each line)
(?n)    # Disables the capturing behavior of `(...)` groups.
        # Named capture groups must be used instead
(?s)    # Single line mode (`.` matches newlines)
(?U)    # Quantifiers are reluctant by default
(?x)    # Enables extended syntax mode, which allows non-semantic whitespace
        # and end-of-line comments
(?xx)   # Same as `(?x)`

# ICU options
# (?w)  # Enables the Unicode interpretation of word boundaries \b

# Oniguruma options
(?D)    # Enables ASCII-only digit matching for \d, \p{Digit}, [:digit:]
(?S)    # Enables ASCII-only space matching for \s, \p{Space}, [:space:]
(?W)    # Enables ASCII-only word matching for \w, \p{Word}, [:word:], and \b
(?P)    # Enables ASCII-only for all POSIX properties (including digit, space,
        # and word)

# Changes the meaning of `\X`, `\y`, `\Y`
# (?y{g}) # extended grapheme cluster mode
# (?y{w}) # word mode

# Swift options
# (?X) # Grapheme semantic mode
# (?u) # Unicode scalar semantic mode
# (?b) # Byte semantic mode
/#

#/
# Part of an isolated group
(?i)i
a(?i)b|c|d # Same as a(?i:b)|(?i:c)|(?i:d)

# As a group specifier
(?i:i)

(?i)a(?-i:a) # Matches `Aa` and `aa`
/#
//: ## References
do {
  let regex = #/
  (?<name>\d)

  # Backreferences
  \1
  \k<name>

  \k<1>
  \k{name}
  \k'name'
  \k'1'
  \g{name}
  \g{1}
  \g1
  (?P=name)
  /#

  let string = "11111111111"
  string.firstMatch(of: regex)!.0
}
/*:
 ## Unimplemented
 - Subpatterns
 - Conditionals
 - PCRE backtracking directives
 - PCRE global matching options
 - Callouts
 - Absent functions
 */
//: [Next](@next)
