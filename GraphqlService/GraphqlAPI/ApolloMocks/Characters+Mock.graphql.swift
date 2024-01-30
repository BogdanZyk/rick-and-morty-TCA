// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import GraphqlAPI

public class Characters: MockObject {
  public static let objectType: ApolloAPI.Object = GraphqlAPI.Objects.Characters
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Characters>>

  public struct MockFields {
    @Field<Info>("info") public var info
    @Field<[Character?]>("results") public var results
  }
}

public extension Mock where O == Characters {
  convenience init(
    info: Mock<Info>? = nil,
    results: [Mock<Character>?]? = nil
  ) {
    self.init()
    _setEntity(info, for: \.info)
    _setList(results, for: \.results)
  }
}
