// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PaginatedLocationsQuery: GraphQLQuery {
  public static let operationName: String = "PaginatedLocations"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query PaginatedLocations($page: Int, $filter: FilterLocation) { locations(page: $page, filter: $filter) { __typename info { __typename ...PaginatedInfo } results { __typename ...PaginatedLocation } } }"#,
      fragments: [PaginatedInfo.self, PaginatedLocation.self]
    ))

  public var page: GraphQLNullable<Int>
  public var filter: GraphQLNullable<FilterLocation>

  public init(
    page: GraphQLNullable<Int>,
    filter: GraphQLNullable<FilterLocation>
  ) {
    self.page = page
    self.filter = filter
  }

  public var __variables: Variables? { [
    "page": page,
    "filter": filter
  ] }

  public struct Data: GraphqlAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("locations", Locations?.self, arguments: [
        "page": .variable("page"),
        "filter": .variable("filter")
      ]),
    ] }

    /// Get the list of all locations
    public var locations: Locations? { __data["locations"] }

    public init(
      locations: Locations? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": GraphqlAPI.Objects.Query.typename,
          "locations": locations._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(PaginatedLocationsQuery.Data.self)
        ]
      ))
    }

    /// Locations
    ///
    /// Parent Type: `Locations`
    public struct Locations: GraphqlAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Locations }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("info", Info?.self),
        .field("results", [Result?]?.self),
      ] }

      public var info: Info? { __data["info"] }
      public var results: [Result?]? { __data["results"] }

      public init(
        info: Info? = nil,
        results: [Result?]? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": GraphqlAPI.Objects.Locations.typename,
            "info": info._fieldData,
            "results": results._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(PaginatedLocationsQuery.Data.Locations.self)
          ]
        ))
      }

      /// Locations.Info
      ///
      /// Parent Type: `Info`
      public struct Info: GraphqlAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Info }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(PaginatedInfo.self),
        ] }

        /// Number of the next page (if it exists)
        public var next: Int? { __data["next"] }
        /// The amount of pages.
        public var pages: Int? { __data["pages"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var paginatedInfo: PaginatedInfo { _toFragment() }
        }

        public init(
          next: Int? = nil,
          pages: Int? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": GraphqlAPI.Objects.Info.typename,
              "next": next,
              "pages": pages,
            ],
            fulfilledFragments: [
              ObjectIdentifier(PaginatedLocationsQuery.Data.Locations.Info.self),
              ObjectIdentifier(PaginatedInfo.self)
            ]
          ))
        }
      }

      /// Locations.Result
      ///
      /// Parent Type: `Location`
      public struct Result: GraphqlAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GraphqlAPI.Objects.Location }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(PaginatedLocation.self),
        ] }

        /// The id of the location.
        public var id: GraphqlAPI.ID? { __data["id"] }
        /// The name of the location.
        public var name: String? { __data["name"] }
        /// The type of the location.
        public var type: String? { __data["type"] }
        /// The dimension in which the location is located.
        public var dimension: String? { __data["dimension"] }
        /// List of characters who have been last seen in the location.
        public var residents: [PaginatedLocation.Resident?] { __data["residents"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var paginatedLocation: PaginatedLocation { _toFragment() }
        }

        public init(
          id: GraphqlAPI.ID? = nil,
          name: String? = nil,
          type: String? = nil,
          dimension: String? = nil,
          residents: [PaginatedLocation.Resident?]
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": GraphqlAPI.Objects.Location.typename,
              "id": id,
              "name": name,
              "type": type,
              "dimension": dimension,
              "residents": residents._fieldData,
            ],
            fulfilledFragments: [
              ObjectIdentifier(PaginatedLocationsQuery.Data.Locations.Result.self),
              ObjectIdentifier(PaginatedLocation.self)
            ]
          ))
        }
      }
    }
  }
}
