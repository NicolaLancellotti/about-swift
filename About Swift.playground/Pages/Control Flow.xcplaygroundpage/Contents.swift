//: [Previous](@previous)
//: # Control Flow
let condition1 = false
let condition2 = false
let condition3 = false
//: ## For-in
//: 0 <= i <= 4
for i in 0...4  {
  // do something
}
//: 0 <= i < 4
for _ in 0..<4 {
  // do something
}
/*:
 * callout(Wildcard Pattern):
 A wildcard pattern matches and ignores any value and consists of an underscore
 (`_`).
 Use a wildcard pattern when you don’t care about the values being matched
 against.
 */
//: i = 0, 2, 4
for i in 0...4 where i.isMultiple(of: 2) {
  // do something
}
//: is the same of:
for i in 0...4 {
  if i.isMultiple(of: 2) {
    // do something
  }
}
//: ## While
while condition1 {
  // do something
}
//: ## Repeat-while
repeat {
  // do something
} while condition1
//: ## If
if condition1 {
  // do something
} else if condition2 {
  // do something
} else {
  // do something
}
//: ### If expression
let greeting = if condition1 {
  "Hello!"
} else {
  "Ciao!"
}
/*:
 ## Switch
 
 * Every switch statement must be exhaustive. (If it’s not appropriate to
 provide a case for every possible value, you can define a default case to cover
 any values that are not addressed explicitly).
 * The body of each case must contain at least one executable statement.
 * No implicit fallthrough.
 */
var number = 0

switch number {
  case 0:
    print("Zero")
  case 1:
    print("One")
  default:
    print("Neither zero nor one")
}
//: ### Where & value bindings
number = 12

switch number {
  case let x where x.isMultiple(of: 2):
    print("\(number) is even")
  default:
    print("\(number) is odd")
}
//: ### Interval matching
number = 0

switch number {
  case 0...5:
    print("0 <= x <= 5")
  default:
    print("x >= 6 || x <= -1")
}
//: ### Compound cases
let character: Character = "e"
switch character {
  case "a", "e", "i", "o", "u":
    print("\(character) is a vowel")
  default:
    print("\(character) is not a vowel")
}
//: ### Compound cases can also include value bindings
let point = (9, 0)
switch point {
  case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
  default:
    print("Not on an axis")
}
//: ### Switch expression
let greeting2 = switch condition1 {
  case true: "Hello!"
  case false: "Ciao!"
}
/*:
 ## Control transfer statements
 
 * `continue`  - A continue statement ends program execution of the current
 iteration of a loop statement but does not stop execution of the loop
 statement.
 * `break`  - A break statement ends program execution of a loop, an if
 statement, or a switch statement.
 * `fallthrough` - A fallthrough statement continue execution from one case to
 the next of a switch.
 */
//: ## Labeled statements
label1: while condition1 {
  while condition2 {
    if condition3 {
      continue label1
    }
    // do something
  }
}

label2: for _ in 1...4 {
  // do something
}

label3: if condition1 {
  // do something
}
//: [Next](@next)
