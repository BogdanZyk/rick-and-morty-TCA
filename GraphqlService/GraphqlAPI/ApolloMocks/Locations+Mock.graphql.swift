// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import GraphqlAPI

public class Locations: MockObject {
  public static let objectType: ApolloAPI.Object = GraphqlAPI.Objects.Locations
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Locations>>

  public struct MockFields {
    @Field<Info>("info") public var info
    @Field<[Location?]>("results") public var results
  }
}

public extension Mock where O == Locations {
  convenience init(
    info: Mock<Info>? = nil,
    results: [Mock<Location>?]? = nil
  ) {
    self.init()
    _setEntity(info, for: \.info)
    _setList(results, for: \.results)
  }
}
