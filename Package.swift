// swift-tools-version:5.3

import Foundation
import PackageDescription

var sources = ["src/parser.c"]
if FileManager.default.fileExists(atPath: "src/scanner.c") {
    sources.append("src/scanner.c")
}

let package = Package(
    name: "TreeSitterProperties",
    products: [
        .library(name: "TreeSitterProperties", targets: ["TreeSitterProperties"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterProperties",
            dependencies: [],
            path: ".",
            sources: sources,
            resources: [
                .copy("queries")
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .testTarget(
            name: "TreeSitterPropertiesTests",
            dependencies: [
                "SwiftTreeSitter",
                "TreeSitterProperties",
            ],
            path: "bindings/swift/TreeSitterPropertiesTests"
        )
    ],
    cLanguageStandard: .c11
)
