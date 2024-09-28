// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AboutSwiftAdvanced",
  targets: [
    .executableTarget(name: "AboutSwiftAdvanced",
                      dependencies: [
                        "ImportC",
                        "ImportCAsMembers",
                        "ImportCAsOpaqueWrapper",
                        "ImportObjC",
                        "UseImportSwift"
                      ],
                      path: "Sources/AboutSwiftAdvanced"),
    // Import C A Members
    .target(name: "ImportCAsMembers",
            path: "Sources/C/ImportCAsMembers"),
    // Import C As Opaque
    .target(name: "ImportCAsOpaque",
            path: "Sources/C/ImportCAsOpaque"),
    // Import C
    .target(name: "ImportC",
            path: "Sources/C/ImportC"),
    .target(name: "ImportCAsOpaqueWrapper",
            dependencies: ["ImportCAsOpaque"],
            path: "Sources/Swift/ImportCAsOpaqueWrapper"),
    // Import Objective-C
    .target(name: "ImportObjC",
            path: "Sources/Objective-C/ImportObjC"),
    // Import Swift
    .target(name: "ImportSwiftHeaders",
            path: "Sources/C/ImportSwiftHeaders"),
    .target(name: "ImportSwift",
            dependencies: ["ImportSwiftHeaders"],
            path: "Sources/Swift/ImportSwift"),
    .target(name: "UseImportSwift",
            dependencies: ["ImportSwift"],
            path: "Sources/C/UseImportSwift"),
  ]
)
