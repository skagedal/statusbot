// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "statusbot",
    dependencies: [
        .Package(url: "https://github.com/skagedal/SlackKit.git", "3.1.13-skr"),
    ]
)
