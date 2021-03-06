// swift-tools-version:5.3
import PackageDescription

let isLocalTestMode = false

var deps: [Package.Dependency] = [
    .package(url: "https://github.com/binarybirds/feather-core", from: "1.0.0-beta"),
]

var targets: [Target] = [
    .target(name: "SponsorModule", dependencies: [
        .product(name: "FeatherCore", package: "feather-core"),
    ],
    resources: [
        .copy("Bundle"),
    ]),
]

// @NOTE: https://bugs.swift.org/browse/SR-8658
if isLocalTestMode {
    deps.append(contentsOf: [
        /// drivers
        .package(url: "https://github.com/vapor/fluent-sqlite-driver", from: "4.0.0"),
        .package(url: "https://github.com/binarybirds/liquid-local-driver", from: "1.2.0-beta"),
        /// core modules
        .package(url: "https://github.com/feathercms/common-module", from: "1.0.0-beta"),
        .package(url: "https://github.com/feathercms/system-module", from: "1.0.0-beta"),
        .package(url: "https://github.com/feathercms/user-module", from: "1.0.0-beta"),
        .package(url: "https://github.com/feathercms/api-module", from: "1.0.0-beta"),
        .package(url: "https://github.com/feathercms/admin-module", from: "1.0.0-beta"),
        .package(url: "https://github.com/feathercms/frontend-module", from: "1.0.0-beta"),
    ])
    targets.append(contentsOf: [
        .target(name: "Feather", dependencies: [
            /// drivers
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "LiquidLocalDriver", package: "liquid-local-driver"),
            /// core modules
            .product(name: "CommonModule", package: "common-module"),
            .product(name: "SystemModule", package: "system-module"),
            .product(name: "UserModule", package: "user-module"),
            .product(name: "ApiModule", package: "api-module"),
            .product(name: "AdminModule", package: "admin-module"),
            .product(name: "FrontendModule", package: "frontend-module"),

            .target(name: "SponsorModule"),
        ]),
        .testTarget(name: "SponsorModuleTests", dependencies: [
            .target(name: "SponsorModule"),
        ])
    ])
}

let package = Package(
    name: "sponsor-module",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "SponsorModule", targets: ["SponsorModule"]),
    ],
    dependencies: deps,
    targets: targets
)
