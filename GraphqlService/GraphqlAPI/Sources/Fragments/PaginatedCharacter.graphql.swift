// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct PaginatedCharacter: GraphqlAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment PaginatedCharacter on Character { __typename id name type gender image }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Character }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", GraphqlAPI.ID?.self),
    .field("name", String?.self),
    .field("type", String?.self),
    .field("gender", String?.self),
    .field("image", String?.self),
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
        ObjectIdentifier(PaginatedCharacter.self)
      ]
    ))
  }
}
