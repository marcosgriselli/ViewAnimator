// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Kingfisher",
    platforms: [.iOS(.v10), .tvOS(.v10)]
    products: [
        .library(name: "ViewAnimator", targets: ["ViewAnimator"]),
    ],
    targets: [
        .target(
            name: "ViewAnimator",
            path: "ViewAnimator/Classes"
        )
    ]
)
