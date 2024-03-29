// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package = Package(
  name: "UniquelyTypedID",
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
  products: [
    .library(
      name: "UniquelyTypedID",
      targets: ["UniquelyTypedID"]
    ),
    .executable(
      name: "UniquelyTypedIDClient",
      targets: ["UniquelyTypedIDClient"]
    ),
  ],
  dependencies: [
    // Depend on the latest Swift 5.9 prerelease of SwiftSyntax
    .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
  ],
  targets: [
    // Macro implementation that performs the source transformation of a macro.
    .macro(
      name: "UniquelyTypedIDMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),

    // Library that exposes a macro as part of its API, which is used in client programs.
    .target(name: "UniquelyTypedID", dependencies: ["UniquelyTypedIDMacros"]),

    // A client of the library, which is able to use the macro in its own code.
    .executableTarget(name: "UniquelyTypedIDClient", dependencies: ["UniquelyTypedID"]),

    // A test target used to develop the macro implementation.
    .testTarget(
      name: "UniquelyTypedIDTests",
      dependencies: [
        "UniquelyTypedIDMacros",
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
      ]
    ),
  ]
)
