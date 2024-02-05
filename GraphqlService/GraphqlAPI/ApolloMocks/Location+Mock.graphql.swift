// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import GraphqlAPI

public class Location: MockObject {
  public static let objectType: ApolloAPI.Object = GraphqlAPI.Objects.Location
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Location>>

  public struct MockFields {
    @Field<String>("dimension") public var dimension
    @Field<GraphqlAPI.ID>("id") public var id
    @Field<String>("name") public var name
    @Field<[Character?]>("residents") public var residents
    @Field<String>("type") public var type
  }
}

public extension Mock where O == Location {
  convenience init(
    dimension: String? = nil,
    id: GraphqlAPI.ID? = nil,
    name: String? = nil,
    residents: [Mock<Character>?]? = nil,
    type: String? = nil
  ) {
    self.init()
    _setScalar(dimension, for: \.dimension)
    _setScalar(id, for: \.id)
    _setScalar(name, for: \.name)
    _setList(residents, for: \.residents)
    _setScalar(type, for: \.type)
  }
}
