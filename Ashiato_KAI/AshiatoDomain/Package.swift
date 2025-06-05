// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AshiatoDomain",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AshiatoDomain",
            targets: ["AshiatoDomain"]
        )
    ],
    dependencies: [
        // Add shared dependencies if needed
    ],
    targets: [
        .target(
            name: "AshiatoDomain",
            dependencies: []
        ),
//        .testTarget(
//            name: "AshiatoDomainTests",
//            dependencies: ["AshiatoDomain"]
//        )
    ]
)
