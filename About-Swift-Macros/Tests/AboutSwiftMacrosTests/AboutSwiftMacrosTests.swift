import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not
// available when cross-compiling.
// Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(AboutSwiftMacrosMacros)
import AboutSwiftMacrosMacros
#endif

let unsupported = "macros are only supported when running tests for the host platform"

final class AboutSwiftMacrosTests: XCTestCase {
  
  //: MARK: Freestanding Expression Macro
  
  func testFreestandingExpressionMacro() {
#if canImport(AboutSwiftMacrosMacros)
    assertMacroExpansion(
            """
            #sum(1, 2, 3, 4)
            """,
            expandedSource: """
            10
            """,
            macros: ["sum": FreestandingExpressionMacroExample.self]
    )
#else
    throw XCTSkip(unsupported)
#endif
  }
  
  //: MARK: Freestanding Declaration Macro
  
  func testFreestandingDeclarationMacro() {
#if canImport(AboutSwiftMacrosMacros)
    assertMacroExpansion(
            """
            #declareStructWithValue("Hello")
            """,
            expandedSource: """
            struct DeclaredStruct {
              static let value = "Hello"
            }
            """,
            macros: ["declareStructWithValue": FreestandingDeclarationMacroExample.self]
    )
#else
    throw XCTSkip(unsupported)
#endif
  }
  
  //: MARK: Attached Extension Macro
  
  func testAttachedExtensionMacro() {
#if canImport(AboutSwiftMacrosMacros)
    assertMacroExpansion(
            """
            @DeclarePropertyWithValue(value: 10)
            struct Struct {}
            """,
            expandedSource: """
            struct Struct {}
            
            extension Struct: Equatable {
              static let value = 10
            }
            """,
            macros: ["DeclarePropertyWithValue": AttachedExtensionMacroExample.self]
    )
#else
    throw XCTSkip(unsupported)
#endif
  }
  
  //: MARK: Attached Function Body Macro
  
  func testAttachedFunctionBodyMacro() {
#if canImport(AboutSwiftMacrosMacros)
    assertMacroExpansion(
            """
            @Hello
            func printHello() -> Void {}
            """,
            expandedSource: """
            func printHello() -> Void {
                print("Hello")
            }
            """,
            macros: ["Hello": AttachedFunctionBodyMacroExample.self]
    )
#else
    throw XCTSkip(unsupported)
#endif
  }
}
