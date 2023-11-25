// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThmanyahUtilitiesKit",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "EasyConstraints", targets: ["EasyConstraints"]),
        .library(name: "UtilitiesKit", targets: ["UtilitiesKit"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.8.0"),
        .package(url: "https://github.com/marcosgriselli/ViewAnimator.git", from: "3.1.0"),
    ],
    targets: [
        .target(name: "EasyConstraints"),
        .target(name: "DesignSystem",
                dependencies: [
                    "EasyConstraints",
                    "UtilitiesKit",
                ],
                resources: [
                    .process("Resources/assets.xcassets"),
                ]
               ),
        .target(
            name: "UtilitiesKit",
            dependencies: [
                "Kingfisher",
                "ViewAnimator",
            ],
            resources: [
                .process("Resources/Fonts"),
            ]
        ),
    ]
)

