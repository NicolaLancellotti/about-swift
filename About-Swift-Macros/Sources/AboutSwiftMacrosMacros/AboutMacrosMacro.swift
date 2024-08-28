import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

//: MARK: Freestanding Expression Macro

public struct FreestandingExpressionMacroExample: ExpressionMacro {
  public static func expansion(
    of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> SwiftSyntax.ExprSyntax {
    let sum = node.argumentList.map {
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
    of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.DeclSyntax] {
    guard let argument = node.argumentList.first?.expression else {
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
    of node: SwiftSyntax.AttributeSyntax,
    attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
    providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
    conformingTo protocols: [SwiftSyntax.TypeSyntax],
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
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
