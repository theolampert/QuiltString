// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuiltString",
    platforms: [.macOS(.v12), .iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "QuiltString",
            targets: ["QuiltString"]),
    ],
    dependencies: [.package(url: "https://github.com/theolampert/Quilt", branch: "main")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "QuiltString",
            dependencies: ["Quilt"]
        ),
        .testTarget(
            name: "QuiltStringTests",
            dependencies: ["QuiltString"]
        ),
    ]
)
