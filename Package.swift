// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Lingua",
  platforms: [
    .macOS(.v13),
  ],
  products: [
    .library(name: "LinguaLib", targets: ["LinguaLib"]),
    .executable(name: "Lingua", targets: ["Lingua"])
  ],
  targets: [
    .executableTarget(
      name: "Lingua",
      dependencies: ["LinguaLib"]),
    .target(
      name: "LinguaLib",
      dependencies: []),
    .testTarget(
      name: "LinguaTests",
      dependencies: ["Lingua", "LinguaLib"]),
  ]
)
