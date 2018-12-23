// swift-tools-version:4.0
import PackageDescription
let package = Package(
	name: "StORM",
	dependencies: [
        .package(url: "https://github.com/PerfectlySoft/PerfectLib.git", from: "3.0.0"),
        .package(url: "https://github.com/iamjono/SwiftMoment.git", from: "1.0.0"),
		.package(url: "https://github.com/iamjono/SwiftString.git", from: "2.0.0"),
	],
    targets: [
        .target(
            name: "StORM",
            dependencies: ["PerfectLib","SwiftMoment", "SwiftString"],
            path: "Sources/StORM"
        ),
    ]
)
