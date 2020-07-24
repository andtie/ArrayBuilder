// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable prefixed_toplevel_constant

import PackageDescription

let package = Package(
    name: "ArrayBuilder",
    products: [
        .library(name: "ArrayBuilder", targets: ["ArrayBuilder"])
    ],
    targets: [
        .target(name: "ArrayBuilder"),
        .testTarget(name: "ArrayBuilderTests", dependencies: ["ArrayBuilder"])
    ]
)
