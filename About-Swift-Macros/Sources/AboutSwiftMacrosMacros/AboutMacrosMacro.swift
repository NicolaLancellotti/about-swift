import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

//: MARK: Freestanding Expression Macro

public struct FreestandingExpressionMacroExample: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    let sum = node.arguments.map {
      Int($0.expression.as(IntegerLiteralExprSyntax.self)!.literal.text)!
    }.reduce(0) { partialResult, value in
      value + partialResult
    }
    return "\(raw: sum)"
  }
}

//: MARK: Freestanding Declaration Macro

public struct FreestandingDeclarationMacroExample: DeclarationMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard let argument = node.arguments.first?.expression else {
      fatalError("compiler bug: the macro does not have any arguments")
    }
    return ["""
      struct DeclaredStruct {
        static let value = \(argument)
      }
      """
    ]
  }
}

//: MARK: Attached Extension Macro

public struct AttachedExtensionMacroExample: ExtensionMacro {
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    guard case let .argumentList(arguments) = node.arguments,
          let expression = arguments.first?.expression else {
      fatalError("compiler bug: the macro does not have any arguments")
    }
    let decl: DeclSyntax = """
      extension \(type.trimmed): Equatable {
        static let value = \(expression)
      }
      """
    guard let extensionDecl = decl.as(ExtensionDeclSyntax.self) else {
      return []
    }
    return [extensionDecl]
  }
}

//: MARK: Main

@main
struct AboutSwiftMacrosPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    FreestandingExpressionMacroExample.self,
    FreestandingDeclarationMacroExample.self,
    AttachedExtensionMacroExample.self
  ]
}
