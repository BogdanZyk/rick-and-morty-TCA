// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct PaginatedEpisodes: GraphqlAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment PaginatedEpisodes on Episode { __typename id name air_date episode characters { __typename id name } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Episode }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", GraphqlAPI.ID?.self),
    .field("name", String?.self),
    .field("air_date", String?.self),
    .field("episode", String?.self),
    .field("characters", [Character?].self),
  ] }

  /// The id of the episode.
  public var id: GraphqlAPI.ID? { __data["id"] }
  /// The name of the episode.
  public var name: String? { __data["name"] }
  /// The air date of the episode.
  public var air_date: String? { __data["air_date"] }
  /// The code of the episode.
  public var episode: String? { __data["episode"] }
  /// List of characters who have been seen in the episode.
  public var characters: [Character?] { __data["characters"] }

  public init(
    id: GraphqlAPI.ID? = nil,
    name: String? = nil,
    air_date: String? = nil,
    episode: String? = nil,
    characters: [Character?]
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": GraphqlAPI.Objects.Episode.typename,
        "id": id,
        "name": name,
        "air_date": air_date,
        "episode": episode,
        "characters": characters._fieldData,
      ],
      fulfilledFragments: [
        ObjectIdentifier(PaginatedEpisodes.self)
      ]
    ))
  }

  /// Character
  ///
  /// Parent Type: `Character`
  public struct Character: GraphqlAPI.SelectionSet {
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
          ObjectIdentifier(PaginatedEpisodes.Character.self)
        ]
      ))
    }
  }
}
