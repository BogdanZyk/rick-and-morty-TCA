//
//  APIClient.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import ComposableArchitecture

@DependencyClient
struct APIClient {
    var paginatedCharacters: @Sendable (_ page: Int) async throws -> PaginatedResult?
    //var character: @Sendable (_ id: Int) async throws -> String

}

extension APIClient: TestDependencyKey {
    
//  static let previewValue = Self(
//    paginatedCharacters: {_ in
//        return (2, [.init(id: "1"), .init(id: "2")])
//    }
//  )

  static let testValue = Self()
}

extension DependencyValues {
  var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}

extension APIClient: DependencyKey {
  static let liveValue = APIClient(
    paginatedCharacters: {
        return try await APIService.paginatedCharacters(page: $0)
    }
  )
}
