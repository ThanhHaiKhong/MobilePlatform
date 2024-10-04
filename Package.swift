// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MobilePlatform",
    platforms: [
        .iOS(.v16),
        .macOS(.v10_15),
    ],
    products: [
        .singleTargetLibrary("MobileAds"),
        .singleTargetLibrary("MobilePlatformUI"),
        .singleTargetLibrary("MobilePurchase"),
        .singleTargetLibrary("MobileConfigClient"),
        .singleTargetLibrary("MobileSettings"),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", branch: "main"),
        .package(url: "https://github.com/mentalflux/tca-composer.git", branch: "main"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", branch: "main"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", branch: "main"),
        .package(url: "https://github.com/bizz84/SwiftyStoreKit.git", branch: "master"),
        .package(url: "https://github.com/onevcat/Kingfisher", branch: "master"),
    ],
    targets: [
        .target(
            name: "MobileAds",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "TCAComposer", package: "tca-composer"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ]
        ),
        .target(
            name: "MobilePlatformUI",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "TCAComposer", package: "tca-composer"),
                "Kingfisher",
            ]
        ),
        .target(
            name: "MobilePurchase",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "TCAComposer", package: "tca-composer"),
                "SwiftyStoreKit",
            ]
        ),
        .target(
            name: "MobileConfigClient",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "TCAComposer", package: "tca-composer"),
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
            ],
            resources: [
                .process("Resources/RemoteConfigDefaults.plist")
            ]
        ),
        .target(
            name: "MobileSettings",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "TCAComposer", package: "tca-composer"),
            ]
        ),
    ]
)

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
