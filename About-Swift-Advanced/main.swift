
import Foundation

// _____________________________________________________________________________
// MARK: - Command-line arguments for the current process

print("argc: \(CommandLine.argc)")
print("arguments: \(CommandLine.arguments)\n")

// _____________________________________________________________________________
// MARK: - Variable Arguments

/*
 Instances conform to CVarArg can be encoded, and appropriately passed,
 as elements of a C va_list.
 */

// Int32 is conforming to CVarArg
func swiftFuncWithCVarArg(_ x: Int32, arguments: Int32...) -> Int32 {
    let value: Int32
    value = withVaList(arguments) {
        cFuncWithVaList(x, $0)
    }
    
    /*
     This function is best avoided in favor of withVaList, but occasionally
     (i.e. in a class initializer) you may find that the language rules don’t
     allow you to use withVaList as intended.
     */
    //    value = c_api(x, getVaList(arguments))
    
    return value
}

func swiftFuncWithCVarArg(_ x: Int32, arguments: CVarArg...) -> Int32 {
    let value: Int32
    value = withVaList(arguments) {
        cFuncWithVaList(x, $0)
    }
    return value
}


// Int example

var result: Int32

result = swiftFuncWithCVarArg(2, arguments: 1, 2)
assert(result == 3)

// MyInt32 example

struct MyInt32: CVarArg {
    let value: Int32
    var _cVarArgEncoding: [Int] {
        return  [Int(self.value)]
    }
}

result = swiftFuncWithCVarArg(2, arguments: MyInt32(value: 20), MyInt32(value: 10))
assert(result == 30)

// _____________________________________________________________________________
// MARK: - withUnsafe[Mutable]Pointer

var value: Int32 = 99
withUnsafeMutablePointer(to: &value) {
    increment($0)
}
assert(value == 100)


value = 99
let incrementedValue = withUnsafePointer(to: &value) {
    return increment2($0)
}
assert(incrementedValue == 100)


var value0: Int32 = 1
var value1: Int32 = 9

result = withUnsafePointer(to: &value0) { v1 in
    withUnsafePointer(to: &value1) { v2 in
        sum(v1, v2)
    }
}
assert(result == 10)

// _____________________________________________________________________________
// MARK: - Declaring a Swift Error Type That Can Be Used from Objective-C

@objc public enum CustomError: Int, Error {
    case a, b, c
}

// Here’s the corresponding Objective-C declaration in the generated header:

/*
 typedef SWIFT_ENUM(NSInteger, CustomError) {
 CustomErrorA = 0,
 CustomErrorB = 1,
 CustomErrorC = 2,
 };
 
 static NSString * const CustomErrorDomain = @"Project.CustomError";
 */

// _____________________________________________________________________________
// MARK: - Refining Objective-C Declarations

extension NLInteroperability {
    var RGBA: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        __getRed(&r, green: &g, blue: &b, alpha: &a)
        return (red: r, green: g, blue: b, alpha: a)
    }
}
