// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CICOAutoCodable",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "CICOAutoCodable", targets: ["CICOAutoCodable"])
    ],
    targets: [
        .target(
            name: "CICOAutoCodable",
            path: "CICOAutoCodable"
        )
    ]
)
