// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import GraphqlAPI

public class Episodes: MockObject {
  public static let objectType: ApolloAPI.Object = GraphqlAPI.Objects.Episodes
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Episodes>>

  public struct MockFields {
    @Field<Info>("info") public var info
    @Field<[Episode?]>("results") public var results
  }
}

public extension Mock where O == Episodes {
  convenience init(
    info: Mock<Info>? = nil,
    results: [Mock<Episode>?]? = nil
  ) {
    self.init()
    _setEntity(info, for: \.info)
    _setList(results, for: \.results)
  }
}
