// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "statusbot",
    dependencies: [
        .Package(url: "https://github.com/pvzig/SlackKit.git", majorVersion: 0, minor: 0),
    ]
)
