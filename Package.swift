// swift-tools-version: 5.7.1

import PackageDescription
let package = Package(
	name: "Perfect-Blog-Mustache",
	dependencies: [
		.package(url: "https://github.com/PerfectlySoft/Perfect-SQLite.git", from: "3.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", from: "3.0.0"),
		.package(url: "https://github.com/iamjono/SwiftString.git", from: "2.0.0"),
	],
    targets: [
        .executableTarget(
            name: "Blog",
            dependencies: [
                .product(name: "PerfectSQLite", package: "Perfect-SQLite"),
                .product(name: "PerfectHTTPServer", package: "Perfect-HTTPServer"),
                .product(name: "PerfectMustache", package: "Perfect-Mustache"),
                .product(name: "SwiftString", package: "SwiftString"),
            ],
            resources: [
                .copy("Resources"),
            ]
        )
    ]
)
