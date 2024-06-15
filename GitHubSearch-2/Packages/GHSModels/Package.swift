// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GHSModels",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GHSModels",
            targets: ["GHSModels"]
        ),
    ],
    dependencies: [
        .package(name: "GHSDtoModels", path: "../Packages/GHSDtoModels"),
        .package(name: "GHSCoreUI", path: "../Packages/GHSCoreUI"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GHSModels",
            dependencies: [
                .product(name: "GHSDtoModels", package: "GHSDtoModels"),
                .product(name: "GHSCoreUI", package: "GHSCoreUI"),
            ]
        ),

        .testTarget(
            name: "GHSModelsTests",
            dependencies: ["GHSModels"]
        ),
    ]
)
