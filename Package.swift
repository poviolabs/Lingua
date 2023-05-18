// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AssetGen",
  platforms: [
    .macOS(.v12),
  ],
  targets: [
    .executableTarget(
      name: "AssetGen",
      dependencies: []),
    .testTarget(
      name: "AssetGenTests",
      dependencies: ["AssetGen"]),
  ]
)
