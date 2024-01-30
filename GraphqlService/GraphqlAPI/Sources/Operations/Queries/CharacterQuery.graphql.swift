// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CharacterQuery: GraphQLQuery {
  public static let operationName: String = "Character"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Character($characterId: ID!) { character(id: $characterId) { __typename ...CharacterAttrs } }"#,
      fragments: [CharacterAttrs.self]
    ))

  public var characterId: ID

  public init(characterId: ID) {
    self.characterId = characterId
  }

  public var __variables: Variables? { ["characterId": characterId] }

  public struct Data: GraphqlAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("character", Character?.self, arguments: ["id": .variable("characterId")]),
    ] }

    /// Get a specific character by ID
    public var character: Character? { __data["character"] }

    public init(
      character: Character? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": GraphqlAPI.Objects.Query.typename,
          "character": character._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(CharacterQuery.Data.self)
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
        .fragment(CharacterAttrs.self),
      ] }

      /// The name of the character.
      public var name: String? { __data["name"] }
      /// The type or subspecies of the character.
      public var type: String? { __data["type"] }
      /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
      public var gender: String? { __data["gender"] }
      /// Link to the character's image.
      /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
      public var image: String? { __data["image"] }
      /// The id of the character.
      public var id: GraphqlAPI.ID? { __data["id"] }
      /// The status of the character ('Alive', 'Dead' or 'unknown').
      public var status: String? { __data["status"] }
      /// The species of the character.
      public var species: String? { __data["species"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var characterAttrs: CharacterAttrs { _toFragment() }
      }

      public init(
        name: String? = nil,
        type: String? = nil,
        gender: String? = nil,
        image: String? = nil,
        id: GraphqlAPI.ID? = nil,
        status: String? = nil,
        species: String? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": GraphqlAPI.Objects.Character.typename,
            "name": name,
            "type": type,
            "gender": gender,
            "image": image,
            "id": id,
            "status": status,
            "species": species,
          ],
          fulfilledFragments: [
            ObjectIdentifier(CharacterQuery.Data.Character.self),
            ObjectIdentifier(CharacterAttrs.self)
          ]
        ))
      }
    }
  }
}
