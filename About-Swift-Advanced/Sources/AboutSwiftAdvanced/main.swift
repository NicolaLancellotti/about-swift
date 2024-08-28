import ImportC
import ImportCAsMembers
import ImportCAsOpaqueWrapper
import ImportObjC
import UseImportSwift

// _____________________________________________________________________________
// MARK: - Command-line arguments for the current process

func printCommandLineArguments() {
  print("______________________________________________________")
  print("Command-line arguments\n")
  
  print("argc: \(CommandLine.argc)")
  print("arguments: \(CommandLine.arguments)\n")
}
// printCommandLineArguments()

// _____________________________________________________________________________
// MARK: - Import C

/*
 Variable arguments
 Instances that conform to CVarArg can be encoded, and appropriately passed,
 as elements of a C va_list.
 */
do {
  func functionWithCVarArg(_ argc: Int32, arguments: any CVarArg...) -> Int32 {
    // It is best avoided in favor of withVaList
    // return cFuncWithVaList(argc, getVaList(arguments))
    
    return withVaList(arguments) { cFunctionWithVaList(argc, $0) }
  }
  assert(functionWithCVarArg(2, arguments: 1, 2) == 3)
  
  struct MyInt32: CVarArg, ExpressibleByIntegerLiteral {
    let value: Int32
    var _cVarArgEncoding: [Int] { [Int(self.value)] }
    
    init(integerLiteral value: Int32) {
      self.value = value
    }
  }
  assert(functionWithCVarArg(2, arguments: 20 as MyInt32, 10 as MyInt32) == 30)
}

// _____________________________________________________________________________
// MARK: - Import C as members

do {
  assert(ImportCAsMembers.default.value == 10)
  
  var instance = ImportCAsMembers(value: 10)
  assert(instance.value == 10)
  instance.value = 11
  assert(instance.value == 11)
  assert(instance.incremented(by: 2) == 13)
}

// _____________________________________________________________________________
// MARK: - Import C as opaque

do {
  let instance = ImportCAsOpaque(value: 10)
  assert(instance.value == 10)
  instance.value = 11
  assert(instance.value == 11)
}

// _____________________________________________________________________________
// MARK: - Import Obj-C

extension ImportObjC {
  var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    var r = 0.0
    var g = 0.0
    var b = 0.0
    var a = 0.0
    __getRed(&r, green: &g, blue: &b, alpha: &a)
    return (red: r, green: g, blue: b, alpha: a)
  }
}

do {
  // Overriding Swift Names for Objective-C Interfaces
  let instance = ImportObjC(value: 1)
  
  // Refining Objective-C Declarations
  let _ = instance.rgba
  
  // Errors
  let error: NSErrorPointer = nil
  instance.removeItem(withName: "", error: error)
  
  // Subscripts
  _ = instance[1]
  
  // Enums
  switch ImportObjCNonFrozenEnum.case1 {
  case .case1: break
  case .case2: break
  @unknown default: break
  }
  
  switch ImportObjCFrozenEnum.case2 {
  case .caseA: break
  case .case2: break
  }
}

// _____________________________________________________________________________
// MARK: - Use Import Swift

useImportSwift()
