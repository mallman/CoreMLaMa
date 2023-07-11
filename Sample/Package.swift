// swift-tools-version: 5.8

import PackageDescription

let package = Package(
  name: "CoreMLaMa Sample App",
  platforms: [.macOS(.v12)],
  products: [
    .executable(
      name: "CoreMLaMaSample",
      targets: ["Sample"]),
  ],
  dependencies: [],
  targets: [
    .executableTarget(
      name: "Sample",
      resources: [
        .copy("input.jpeg"),
        .copy("mask.png"),
        .copy("LaMa.mlmodelc")
      ])
  ]
)
