// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import GraphqlAPI

public class Character: MockObject {
  public static let objectType: ApolloAPI.Object = GraphqlAPI.Objects.Character
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Character>>

  public struct MockFields {
    @Field<String>("gender") public var gender
    @Field<GraphqlAPI.ID>("id") public var id
    @Field<String>("image") public var image
    @Field<String>("name") public var name
    @Field<String>("species") public var species
    @Field<String>("status") public var status
    @Field<String>("type") public var type
  }
}

public extension Mock where O == Character {
  convenience init(
    gender: String? = nil,
    id: GraphqlAPI.ID? = nil,
    image: String? = nil,
    name: String? = nil,
    species: String? = nil,
    status: String? = nil,
    type: String? = nil
  ) {
    self.init()
    _setScalar(gender, for: \.gender)
    _setScalar(id, for: \.id)
    _setScalar(image, for: \.image)
    _setScalar(name, for: \.name)
    _setScalar(species, for: \.species)
    _setScalar(status, for: \.status)
    _setScalar(type, for: \.type)
  }
}
