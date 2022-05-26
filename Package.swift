// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TouchVisualizer",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "TouchVisualizer",
            targets: ["TouchVisualizer"]),
    ],
    targets: [
        .target(
            name: "TouchVisualizer",
            path: "TouchVisualizer",
            exclude: ["Info.plist"]
        )
    ]
)