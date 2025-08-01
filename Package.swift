// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TextEdit",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "TextEdit", targets: ["TextEdit"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "TextEdit",
            dependencies: [],
            path: "Sources",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "TextEditTests",
            dependencies: ["TextEdit"],
            path: "Tests"
        )
    ]
)