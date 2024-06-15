// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GHSCoreUI",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GHSCoreUI",
            targets: ["GHSCoreUI"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GHSCoreUI",
            dependencies: []
        ),

        .testTarget(
            name: "GHSCoreUITests",
            dependencies: ["GHSCoreUI"]
        ),
    ]
)
