// swift-tools-version: 5.9
import PackageDescription

let commonExcludedFiles: [String] = [
    "../../.swiftlint.yml"
]

let commonLinkerSettings: [LinkerSetting] = [
    .linkedFramework("Combine")
]

let commonPlugins: [Target.PluginUsage] = [
    .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
]

let package = Package(
    name: "AshiatoUtilities",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Utilities", targets: ["Utilities"]),
        .library(name: "AKLogger", targets: ["AKLogger"]),
        .library(name: "Plugins", targets: ["Plugins"]),
        .library(name: "DesignPatterns", targets: ["DesignPatterns"])
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.59.0"),
        .package(url: "https://github.com/johnpatrickmorgan/NavigationBackport", from: "0.9.6"),
    ],
    targets: [
        .target(
            name: "Utilities",
            dependencies: [
            ],
            path: "Sources/Utilities",
            exclude: commonExcludedFiles,
            linkerSettings: commonLinkerSettings + [
                .linkedFramework("SwiftUI")
            ],
            plugins: commonPlugins
        ),
        .target(
            name: "AKLogger",
            dependencies: [
                .target(name: "Utilities")
            ],
            path: "Sources/Logger",
            exclude: commonExcludedFiles,
            linkerSettings: [
                .linkedFramework("OSLog")
            ],
            plugins: commonPlugins
        ),
        .target(
            name: "Plugins",
            path: "Sources/Plugins",
            exclude: commonExcludedFiles,
            linkerSettings: commonLinkerSettings + [
                .linkedFramework("Network")
            ],
            plugins: commonPlugins
        ),
        .target(
            name: "DesignPatterns",
            dependencies: [
                .product(name: "NavigationBackport", package: "NavigationBackport")
            ],
            path: "Sources/DesignPatterns",
            exclude: commonExcludedFiles + [
                "MVVM-C/Sample",
                "MVVM-C/Templates",
                "MVVM-C/Docs"
            ],
            linkerSettings: commonLinkerSettings + [
                .linkedFramework("SwiftUI")
            ],
            plugins: commonPlugins
        ),
        .testTarget(
            name: "UtilitiesTests",
            dependencies: ["Utilities"]
        )
    ]
)
