// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Urban",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "Urban",
            targets: ["Urban"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Urban",
            dependencies: []
        ),
        .testTarget(
            name: "UrbanTests",
            dependencies: ["Urban"]
        )
    ]
)
