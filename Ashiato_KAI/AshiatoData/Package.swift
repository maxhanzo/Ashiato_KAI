// swift-tools-version: 5.9
import PackageDescription

let commonExcludedFiles: [String] = [
    "../../../.swiftlint.yml"
]

let commonLinkerSettings: [LinkerSetting] = [
    .linkedFramework("Combine")
]

let commonPlugins: [Target.PluginUsage] = [
    .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
]

let package = Package(
    name: "GGData",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "NetworkCore",
            targets: ["NetworkCore"]
        ),
        .library(
            name: "DatabaseCore",
            targets: ["DatabaseCore"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.59.0"),
        .package(name: "AshiatoUtilities", path: "../AshiatoUtilities")
    ],
    targets: [
        .target(
            name: "DatabaseCore",
            dependencies: [
                .product(name: "AKLogger", package: "AshiatoUtilities"),
            ],
            path: "Sources/Core/DatabaseCore",
            exclude: commonExcludedFiles,
            linkerSettings: commonLinkerSettings + [
                .linkedFramework("SwiftData"),
            ],
            plugins: commonPlugins
        ),
        .target(
            name: "NetworkCore",
            dependencies: [
                .product(name: "Plugins", package: "AshiatoUtilities"),
                .product(name: "AKLogger", package: "AshiatoUtilities"),
            ],
            path: "Sources/Core/NetworkCore",
            exclude: commonExcludedFiles,
            linkerSettings: commonLinkerSettings + [
                .linkedFramework("Network")
            ],
            plugins: commonPlugins
        ),
        
        
        //
        // Test Targets
        //
        .testTarget(
            name: "AshiatoDataTests",
            dependencies: [
                "DatabaseCore",
                "NetworkCore"
            ]
        ),
    ]
)
