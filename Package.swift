// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Constraints",
    platforms: [
        .iOS(.v11),
        .tvOS(.v11)
    ],
    products: [
        .library(
            name: "Constraints",
            targets: ["Constraints"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Constraints",
            dependencies: [])
    ]
)
