import AboutSwiftMacros

//: MARK: Freestanding Expression Macro

assert(#sum(1, 2, 3, 4) == 10)

//: MARK: Freestanding Declaration Macro

#declareStructWithValue(10)
assert(DeclaredStruct.value == 10)

//: MARK: Attached Extension Macro

@DeclarePropertyWithValue("Hello")
struct Struct {}
assert(Struct.value == "Hello")
assert(Struct() == Struct())
