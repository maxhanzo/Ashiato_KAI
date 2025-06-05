// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AshiatoFeatures",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AshiatoFeatures",
            targets: ["AshiatoFeatures"]
        )
    ],
    dependencies: [
        // Possibly depends on AshiatoDomain
        // .package(path: "../AshiatoDomain")
    ],
    targets: [
        .target(
            name: "AshiatoFeatures",
            dependencies: []
        ),
//        .testTarget(
//            name: "AshiatoFeaturesTests",
//            dependencies: ["AshiatoFeatures"]
//        )
    ]
)
