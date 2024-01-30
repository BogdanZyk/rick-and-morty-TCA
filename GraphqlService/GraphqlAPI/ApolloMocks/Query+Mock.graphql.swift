// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import GraphqlAPI

public class Query: MockObject {
  public static let objectType: ApolloAPI.Object = GraphqlAPI.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<Character>("character") public var character
    @Field<Characters>("characters") public var characters
  }
}

public extension Mock where O == Query {
  convenience init(
    character: Mock<Character>? = nil,
    characters: Mock<Characters>? = nil
  ) {
    self.init()
    _setEntity(character, for: \.character)
    _setEntity(characters, for: \.characters)
  }
}
