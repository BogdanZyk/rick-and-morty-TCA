// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PaginatedEpisodesQuery: GraphQLQuery {
  public static let operationName: String = "PaginatedEpisodes"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query PaginatedEpisodes($page: Int, $filter: FilterEpisode) { episodes(page: $page, filter: $filter) { __typename info { __typename ...PaginatedInfo } results { __typename ...PaginatedEpisodes } } }"#,
      fragments: [PaginatedEpisodes.self, PaginatedInfo.self]
    ))

  public var page: GraphQLNullable<Int>
  public var filter: GraphQLNullable<FilterEpisode>

  public init(
    page: GraphQLNullable<Int>,
    filter: GraphQLNullable<FilterEpisode>
  ) {
    self.page = page
    self.filter = filter
  }

  public var __variables: Variables? { [
    "page": page,
    "filter": filter
  ] }

  public struct Data: GraphqlAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("episodes", Episodes?.self, arguments: [
        "page": .variable("page"),
        "filter": .variable("filter")
      ]),
    ] }

    /// Get the list of all episodes
    public var episodes: Episodes? { __data["episodes"] }

    public init(
      episodes: Episodes? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": GraphqlAPI.Objects.Query.typename,
          "episodes": episodes._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(PaginatedEpisodesQuery.Data.self)
        ]
      ))
    }

    /// Episodes
    ///
    /// Parent Type: `Episodes`
    public struct Episodes: GraphqlAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Episodes }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("info", Info?.self),
        .field("results", [Result?]?.self),
      ] }

      public var info: Info? { __data["info"] }
      public var results: [Result?]? { __data["results"] }

      public init(
        info: Info? = nil,
        results: [Result?]? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": GraphqlAPI.Objects.Episodes.typename,
            "info": info._fieldData,
            "results": results._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(PaginatedEpisodesQuery.Data.Episodes.self)
          ]
        ))
      }

      /// Episodes.Info
      ///
      /// Parent Type: `Info`
      public struct Info: GraphqlAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Info }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(PaginatedInfo.self),
        ] }

        /// Number of the next page (if it exists)
        public var next: Int? { __data["next"] }
        /// The amount of pages.
        public var pages: Int? { __data["pages"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var paginatedInfo: PaginatedInfo { _toFragment() }
        }

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
              ObjectIdentifier(PaginatedEpisodesQuery.Data.Episodes.Info.self),
              ObjectIdentifier(PaginatedInfo.self)
            ]
          ))
        }
      }

      /// Episodes.Result
      ///
      /// Parent Type: `Episode`
      public struct Result: GraphqlAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Episode }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(PaginatedEpisodes.self),
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
        public var characters: [PaginatedEpisodes.Character?] { __data["characters"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var paginatedEpisodes: PaginatedEpisodes { _toFragment() }
        }

        public init(
          id: GraphqlAPI.ID? = nil,
          name: String? = nil,
          air_date: String? = nil,
          episode: String? = nil,
          characters: [PaginatedEpisodes.Character?]
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
              ObjectIdentifier(PaginatedEpisodesQuery.Data.Episodes.Result.self),
              ObjectIdentifier(PaginatedEpisodes.self)
            ]
          ))
        }
      }
    }
  }
}
