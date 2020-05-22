// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StringIntegerAccess",
    
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "StringIntegerAccess",
            targets: ["StringIntegerAccess"]),
        .library(
            name: "SafeStringIntegerAccess",
            targets: ["SafeStringIntegerAccess"]),
    ],
    
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "SafeCollectionAccess", url: "https://github.com/RougeWare/Swift-Safe-Collection-Access.git", from: "2.1.0")
    ],
    
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        
        .target(
            name: "SafeStringIntegerAccess",
            dependencies: ["StringIntegerAccess", "SafeCollectionAccess"]),
        .testTarget(
            name: "SafeStringIntegerAccessTests",
            dependencies: ["SafeStringIntegerAccess"]),
        
        .target(
            name: "StringIntegerAccess",
            dependencies: []),
        .testTarget(
            name: "StringIntegerAccessTests",
            dependencies: ["StringIntegerAccess"]),
    ]
)
