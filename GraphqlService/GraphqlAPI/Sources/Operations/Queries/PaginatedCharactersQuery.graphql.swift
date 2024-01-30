// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PaginatedCharactersQuery: GraphQLQuery {
  public static let operationName: String = "PaginatedCharacters"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query PaginatedCharacters($page: Int, $filter: FilterCharacter) { characters(page: $page, filter: $filter) { __typename info { __typename next } results { __typename ...PaginatedCharacter } } }"#,
      fragments: [PaginatedCharacter.self]
    ))

  public var page: GraphQLNullable<Int>
  public var filter: GraphQLNullable<FilterCharacter>

  public init(
    page: GraphQLNullable<Int>,
    filter: GraphQLNullable<FilterCharacter>
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
      .field("characters", Characters?.self, arguments: [
        "page": .variable("page"),
        "filter": .variable("filter")
      ]),
    ] }

    /// Get the list of all characters
    public var characters: Characters? { __data["characters"] }

    public init(
      characters: Characters? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": GraphqlAPI.Objects.Query.typename,
          "characters": characters._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(PaginatedCharactersQuery.Data.self)
        ]
      ))
    }

    /// Characters
    ///
    /// Parent Type: `Characters`
    public struct Characters: GraphqlAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Characters }
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
            "__typename": GraphqlAPI.Objects.Characters.typename,
            "info": info._fieldData,
            "results": results._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(PaginatedCharactersQuery.Data.Characters.self)
          ]
        ))
      }

      /// Characters.Info
      ///
      /// Parent Type: `Info`
      public struct Info: GraphqlAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Info }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("next", Int?.self),
        ] }

        /// Number of the next page (if it exists)
        public var next: Int? { __data["next"] }

        public init(
          next: Int? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": GraphqlAPI.Objects.Info.typename,
              "next": next,
            ],
            fulfilledFragments: [
              ObjectIdentifier(PaginatedCharactersQuery.Data.Characters.Info.self)
            ]
          ))
        }
      }

      /// Characters.Result
      ///
      /// Parent Type: `Character`
      public struct Result: GraphqlAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Character }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(PaginatedCharacter.self),
        ] }

        /// The id of the character.
        public var id: GraphqlAPI.ID? { __data["id"] }
        /// The name of the character.
        public var name: String? { __data["name"] }
        /// The type or subspecies of the character.
        public var type: String? { __data["type"] }
        /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
        public var gender: String? { __data["gender"] }
        /// Link to the character's image.
        /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
        public var image: String? { __data["image"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var paginatedCharacter: PaginatedCharacter { _toFragment() }
        }

        public init(
          id: GraphqlAPI.ID? = nil,
          name: String? = nil,
          type: String? = nil,
          gender: String? = nil,
          image: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": GraphqlAPI.Objects.Character.typename,
              "id": id,
              "name": name,
              "type": type,
              "gender": gender,
              "image": image,
            ],
            fulfilledFragments: [
              ObjectIdentifier(PaginatedCharactersQuery.Data.Characters.Result.self),
              ObjectIdentifier(PaginatedCharacter.self)
            ]
          ))
        }
      }
    }
  }
}
