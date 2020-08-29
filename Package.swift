// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ViewAnimator",
    platforms: [.iOS(.v10), .tvOS(.v10)],
    products: [
        .library(name: "ViewAnimator", targets: ["ViewAnimator"]),
    ],
    targets: [
        .target(
            name: "ViewAnimator",
            path: "ViewAnimator/Classes"
        )
    ],
    swiftLanguageVersions: [.v5]
)
