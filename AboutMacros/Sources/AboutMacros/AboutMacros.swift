//: MARK: Freestanding Expression Macro

@freestanding(expression)
public macro sum(_ values: Int...) -> Int =
  #externalMacro(module: "AboutMacrosMacros", type: "FreestandingExpressionMacroExample")

//: MARK: Freestanding Declaration Macro

@freestanding(declaration, names: named(DeclaredStruct))
public macro declareStructWithValue<T>(_ value: T) =
  #externalMacro(module: "AboutMacrosMacros", type: "FreestandingDeclarationMacroExample")

//: MARK: Attached Extension Macro

@attached(extension, conformances: Equatable, names: named(value))
public macro DeclarePropertyWithValue<T: Equatable>(_ value: T) =
  #externalMacro(module: "AboutMacrosMacros", type: "AttachedExtensionMacroExample")
