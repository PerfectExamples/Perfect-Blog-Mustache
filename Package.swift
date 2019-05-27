// swift-tools-version:5.0
// Generated automatically by Perfect Assistant Application
// Date: 2017-10-10 14:39:41 +0000
import PackageDescription
let package = Package(
	name: "Perfect-Blog-Mustache",
		dependencies: [
		.package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-SQLite.git", from: "3.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", from: "3.0.0"),
		.package(url: "https://github.com/iamjono/SwiftString.git", from: "2.0.0"),
	],
	targets: [
		.target(name: "Perfect-Blog-Mustache", 
		dependencies: ["PerfectHTTPServer","PerfectSQLite","PerfectMustache","SwiftString"],
		path: "Sources")
	]
)
