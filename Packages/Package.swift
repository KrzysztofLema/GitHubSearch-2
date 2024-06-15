// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .singleTargetLibrary("Settings"),
        .singleTargetLibrary("Coordinators"),
    ],
    dependencies: [
        .package(url: "https://github.com/roberthein/TinyConstraints.git", exact: "4.0.2"),
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", exact: "3.5.8"),
//        .package(url: "https://github.com/krzysztofzablocki/Difference.git", exact: "1.0.2"),
//        .package(url: "https://github.com/vtourraine/AcknowList", exact: "3.0.1"),
//        .package(url: "https://github.com/krzysztofzablocki/LifetimeTracker.git", exact: "1.8.2"),
//        .package(url: "https://github.com/AvdLee/Roadmap.git", branch: "main"),
//        .package(url: "https://github.com/playbook-ui/playbook-ios", exact: "0.3.4"),
//        .package(url: "https://github.com/krzysztofzablocki/AutomaticSettings", exact: "1.1.0"),
//        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TabBarCoordinator", dependencies: ["CocoaLumberjackSwift"]
        ),
        .target(
            name: "Settings", dependencies: ["CocoaLumberjackSwift"]
        ),
    ]
)

// Inject base plugins into each target
package.targets = package.targets.map { target in
    var plugins = target.plugins ?? []
    plugins.append(.plugin(name: "SwiftLintPlugin", package: "SwiftLint"))
    target.plugins = plugins
    return target
}

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
