// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "GraphqlAPI",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
  ],
  products: [
    .library(name: "GraphqlAPI", targets: ["GraphqlAPI"]),
    .library(name: "ApolloMocks", targets: ["ApolloMocks"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "GraphqlAPI",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
    .target(
      name: "ApolloMocks",
      dependencies: [
        .product(name: "ApolloTestSupport", package: "apollo-ios"),
        .target(name: "GraphqlAPI"),
      ],
      path: "./ApolloMocks"
    ),
  ]
)
