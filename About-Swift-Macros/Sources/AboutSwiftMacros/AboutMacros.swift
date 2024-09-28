//: MARK: Freestanding Expression Macro

@freestanding(expression)
public macro sum(_ values: Int...) -> Int =
  #externalMacro(module: "AboutSwiftMacrosMacros", type: "FreestandingExpressionMacroExample")

//: MARK: Freestanding Declaration Macro

@freestanding(declaration, names: named(DeclaredStruct))
public macro declareStructWithValue<T>(_ value: T) =
  #externalMacro(module: "AboutSwiftMacrosMacros", type: "FreestandingDeclarationMacroExample")

//: MARK: Attached Extension Macro

@attached(extension, conformances: Equatable, names: named(value))
public macro DeclarePropertyWithValue<T: Equatable>(_ value: T) =
  #externalMacro(module: "AboutSwiftMacrosMacros", type: "AttachedExtensionMacroExample")

//: MARK: Attached Function Body Macro

@attached(body)
public macro Hello() =
  #externalMacro(module: "AboutSwiftMacrosMacros", type: "AttachedFunctionBodyMacroExample")
