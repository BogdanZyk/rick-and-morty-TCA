// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct PaginatedLocation: GraphqlAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment PaginatedLocation on Location { __typename id name type dimension residents { __typename id name } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Location }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", GraphqlAPI.ID?.self),
    .field("name", String?.self),
    .field("type", String?.self),
    .field("dimension", String?.self),
    .field("residents", [Resident?].self),
  ] }

  /// The id of the location.
  public var id: GraphqlAPI.ID? { __data["id"] }
  /// The name of the location.
  public var name: String? { __data["name"] }
  /// The type of the location.
  public var type: String? { __data["type"] }
  /// The dimension in which the location is located.
  public var dimension: String? { __data["dimension"] }
  /// List of characters who have been last seen in the location.
  public var residents: [Resident?] { __data["residents"] }

  public init(
    id: GraphqlAPI.ID? = nil,
    name: String? = nil,
    type: String? = nil,
    dimension: String? = nil,
    residents: [Resident?]
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": GraphqlAPI.Objects.Location.typename,
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": residents._fieldData,
      ],
      fulfilledFragments: [
        ObjectIdentifier(PaginatedLocation.self)
      ]
    ))
  }

  /// Resident
  ///
  /// Parent Type: `Character`
  public struct Resident: GraphqlAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Character }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", GraphqlAPI.ID?.self),
      .field("name", String?.self),
    ] }

    /// The id of the character.
    public var id: GraphqlAPI.ID? { __data["id"] }
    /// The name of the character.
    public var name: String? { __data["name"] }

    public init(
      id: GraphqlAPI.ID? = nil,
      name: String? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": GraphqlAPI.Objects.Character.typename,
          "id": id,
          "name": name,
        ],
        fulfilledFragments: [
          ObjectIdentifier(PaginatedLocation.Resident.self)
        ]
      ))
    }
  }
}
