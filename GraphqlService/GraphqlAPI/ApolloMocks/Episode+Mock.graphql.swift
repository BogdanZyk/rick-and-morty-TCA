// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import GraphqlAPI

public class Episode: MockObject {
  public static let objectType: ApolloAPI.Object = GraphqlAPI.Objects.Episode
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Episode>>

  public struct MockFields {
    @Field<String>("air_date") public var air_date
    @Field<[Character?]>("characters") public var characters
    @Field<String>("episode") public var episode
    @Field<GraphqlAPI.ID>("id") public var id
    @Field<String>("name") public var name
  }
}

public extension Mock where O == Episode {
  convenience init(
    air_date: String? = nil,
    characters: [Mock<Character>?]? = nil,
    episode: String? = nil,
    id: GraphqlAPI.ID? = nil,
    name: String? = nil
  ) {
    self.init()
    _setScalar(air_date, for: \.air_date)
    _setList(characters, for: \.characters)
    _setScalar(episode, for: \.episode)
    _setScalar(id, for: \.id)
    _setScalar(name, for: \.name)
  }
}
