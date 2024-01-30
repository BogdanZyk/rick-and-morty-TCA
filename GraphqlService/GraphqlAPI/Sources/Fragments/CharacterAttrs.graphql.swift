// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CharacterAttrs: GraphqlAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CharacterAttrs on Character { __typename name type gender image id status species }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Character }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("name", String?.self),
    .field("type", String?.self),
    .field("gender", String?.self),
    .field("image", String?.self),
    .field("id", GraphqlAPI.ID?.self),
    .field("status", String?.self),
    .field("species", String?.self),
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
        ObjectIdentifier(CharacterAttrs.self)
      ]
    ))
  }
}
