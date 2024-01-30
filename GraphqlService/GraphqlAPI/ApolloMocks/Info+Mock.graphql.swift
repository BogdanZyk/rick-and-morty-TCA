// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import GraphqlAPI

public class Info: MockObject {
  public static let objectType: ApolloAPI.Object = GraphqlAPI.Objects.Info
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Info>>

  public struct MockFields {
    @Field<Int>("next") public var next
    @Field<Int>("pages") public var pages
  }
}

public extension Mock where O == Info {
  convenience init(
    next: Int? = nil,
    pages: Int? = nil
  ) {
    self.init()
    _setScalar(next, for: \.next)
    _setScalar(pages, for: \.pages)
  }
}
