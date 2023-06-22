// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Lingua",
  platforms: [
    .macOS(.v12),
  ],
  targets: [
    .executableTarget(
      name: "Lingua",
      dependencies: []),
    .testTarget(
      name: "LinguaTests",
      dependencies: ["Lingua"]),
  ]
)
