// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct PaginatedInfo: GraphqlAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment PaginatedInfo on Info { __typename next pages }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Info }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("next", Int?.self),
    .field("pages", Int?.self),
  ] }

  /// Number of the next page (if it exists)
  public var next: Int? { __data["next"] }
  /// The amount of pages.
  public var pages: Int? { __data["pages"] }

  public init(
    next: Int? = nil,
    pages: Int? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": GraphqlAPI.Objects.Info.typename,
        "next": next,
        "pages": pages,
      ],
      fulfilledFragments: [
        ObjectIdentifier(PaginatedInfo.self)
      ]
    ))
  }
}
