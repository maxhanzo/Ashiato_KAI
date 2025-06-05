// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AshiatoData",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AshiatoData",
            targets: ["AshiatoData"]
        )
    ],
    dependencies: [
        // Add shared dependencies here if any
    ],
    targets: [
        .target(
            name: "AshiatoData",
            dependencies: []
        ),
//        .testTarget(
//            name: "AshiatoDataTests",
//            dependencies: ["AshiatoData"]
//        )
    ]
)
