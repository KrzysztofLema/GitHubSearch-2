// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GHSLoginFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GHSLoginFeature",
            targets: ["GHSLoginFeature"]
        ),

    ],
    dependencies: [
        .package(name: "GHSDependecyInjection", path: "../Packages/GHSDependecyInjection"),
        .package(name: "GHSModels", path: "../Packages/GHSModels"),
        .package(name: "GHSExtensions", path: "../Packages/GHSExtensions"),
        .package(name: "GHSCoreUI", path: "../Packages/GHSCoreUI"),
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", from: "3.8.5"),
        .package(url: "https://github.com/roberthein/TinyConstraints.git", from: "4.0.2"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.28.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", from: "7.1.0"),
        .package(url: "https://github.com/facebook/facebook-ios-sdk.git", from: "17.0.2"),

    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GHSLoginFeature",
            dependencies: [
                "GHSDependecyInjection",
                "GHSModels",
                "GHSCoreUI",
                "GHSExtensions",
                "CocoaLumberjack",
                "TinyConstraints",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "CocoaLumberjackSwift", package: "CocoaLumberjack"),
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
                .product(name: "FacebookLogin", package: "facebook-ios-sdk"),
            ],
            resources: [.copy("Resources/Assets.xcassets")]
        ),
        .testTarget(
            name: "GHSLoginFeatureTests",
            dependencies: ["GHSLoginFeature"]
        ),
    ]
)
