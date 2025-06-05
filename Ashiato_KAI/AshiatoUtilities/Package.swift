// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AshiatoUtilities",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "AshiatoUtilities",
            targets: ["AshiatoUtilities"]
        ),
    ],
    targets: [
        .target(
            name: "AshiatoUtilities",
            path: "Sources", // all subfolders will be merged
            exclude: [],
            resources: [],
            publicHeadersPath: nil
        )
    ]
)
