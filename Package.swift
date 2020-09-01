// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ViewAnimator",
    platforms: [.iOS(.v9), .tvOS(.v9)],
    products: [
        .library(name: "ViewAnimator", targets: ["ViewAnimator"]),
    ],
    targets: [
        .target(
            name: "ViewAnimator",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "ViewAnimatorTests",
            dependencies: ["ViewAnimator"],
            path: "ViewAnimatorTests"),
    ],
    swiftLanguageVersions: [.v5]
)
