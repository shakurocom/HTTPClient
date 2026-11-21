// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTTPClient",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "HTTPClient",
            targets: ["HTTPClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMinor(from: "5.10.2")),
        .package(url: "https://github.com/shakurocom/CommonTypes.git", from: "1.9.6"),
    ],
    targets: [
        .target(
            name: "HTTPClient",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "CommonTypes", package: "CommonTypes"),
            ],
            path: "Source"),
    ]
)
