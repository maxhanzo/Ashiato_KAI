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
    name: "AshiatoDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DomainModule",
            targets: ["DomainModule"]
        ),
        .library(
            name: "UseCases",
            targets: ["UseCases"]
        ),
        .library(
            name: "Models",
            targets: ["Models"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.59.0"),
        .package(name: "AshiatoData", path: "../AshiatoData"),
        .package(name: "AshiatoUtilities", path: "../AshiatoUtilities"),
    ],
    targets: [
        .target(
            name: "DomainModule",
            dependencies: [
                .target(name: "UseCases")
            ],
            path: "Sources/Module",
            exclude: commonExcludedFiles,
            linkerSettings: commonLinkerSettings,
            plugins: commonPlugins
        ),
        .target(
            name: "UseCases",
            dependencies: [
                .target(name: "Repositories")
            ],
            path: "Sources/UseCases",
            exclude: commonExcludedFiles,
            linkerSettings: commonLinkerSettings,
            plugins: commonPlugins
        ),
        .target(
            name: "Repositories",
            dependencies: [
                .target(name: "Services"),
                .target(name: "DatabaseExtensions")
            ],
            path: "Sources/Repositories",
            exclude: commonExcludedFiles,
            linkerSettings: commonLinkerSettings,
            plugins: commonPlugins
        ),
        .target(
            name: "Services",
            dependencies: [
                .target(name: "GeneralExtensions"),
                .product(name: "NetworkCore", package: "AshiatoData")
            ],
            path: "Sources/Services",
            exclude: commonExcludedFiles,
            linkerSettings: commonLinkerSettings,
            plugins: commonPlugins
        ),
        .target(
            name: "DTOs",
            path: "Sources/DTOs",
            exclude: commonExcludedFiles,
            linkerSettings: commonLinkerSettings,
            plugins: commonPlugins
        ),
        .target(
            name: "DatabaseExtensions",
            dependencies: [
                .product(name: "DatabaseCore", package: "AshiatoData"),
                .target(name: "Models")
            ],
            path: "Sources/Helpers/DatabaseExtensions",
            exclude: ["../../../.swiftlint.yml"],
            linkerSettings: commonLinkerSettings,
            plugins: commonPlugins
        ),
        .target(
            name: "GeneralExtensions",
            dependencies: [
                .target(name: "DTOs"),
                .target(name: "Models"),
                .target(name: "Errors"),
                .product(name: "Utilities", package: "AshiatoUtilities"),
                .product(name: "AKLogger", package: "AshiatoUtilities")
            ],
            path: "Sources/Helpers/GeneralExtensions",
            exclude: ["../../../.swiftlint.yml"],
            linkerSettings: commonLinkerSettings,
            plugins: commonPlugins
        ),
        .target(
            name: "Errors",
            dependencies: [
                .product(name: "Utilities", package: "AshiatoUtilities")
            ],
            path: "Sources/Errors",
            exclude: commonExcludedFiles,
            plugins: commonPlugins
        ),
        //
        // Test Targets
        //
        .testTarget(
            name: "AshiatoDomainTests",
            dependencies: ["UseCases"]
        ),
    ]
)

