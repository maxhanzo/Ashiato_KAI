import PackageDescription

let commonExcludedFiles: [String] = [
    "../../.swiftlint.yml"
]

let commonLinkerSettings: [LinkerSetting] = [
    .linkedFramework("SwiftUI"),
    .linkedFramework("Combine")
]

let commonPlugins: [Target.PluginUsage] = [
    .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
]

let package = Package(
    name: "AshiatoFeatures",
    platforms: [.iOS(.v17)],
    products: [
//        .library(
//            name: "AshiatoActivity",
//            targets: ["AshiatoActivity"]
//        ),
//        .library(
//            name: "AshiatoMyRounds",
//            targets: ["AshiatoMyRounds"]
//        ),
//        .library(
//            name: "AshiatoPlayGolf",
//            targets: ["AshiatoPlayGolf"]
//        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.59.0"),
        .package(name: "AshiatoDomain", path: "../AshiatoDomain"),
        .package(name: "AshiatoUtilities", path: "../AshiatoUtilities")
    ],
    targets: [
//        .target(
//            name: "AshiatoActivity",
//            dependencies: commonDependencies,
//            path: "Sources/AshiatoActivity",
//            exclude: commonExcludedFiles,
//            linkerSettings: commonLinkerSettings,
//            plugins: commonPlugins
//        ),
//        .target(
//            name: "AshiatoMyRounds",
//            dependencies: commonDependencies,
//            path: "Sources/AshiatoMyRounds",
//            exclude: commonExcludedFiles,
//            linkerSettings: commonLinkerSettings,
//            plugins: commonPlugins
//        ),
//        .target(
//            name: "AshiatoPlayGolf",
//            dependencies: [
//                .target(name: "AshiatoKzn")
//            ],
//            path: "Sources/AshiatoPlayGolf",
//            exclude: commonExcludedFiles,
//            linkerSettings: commonLinkerSettings,
//            plugins: commonPlugins
//        ),


        .testTarget(
            name: "AshiatoFeaturesTests",
            dependencies: []
        ),
    ]
)
