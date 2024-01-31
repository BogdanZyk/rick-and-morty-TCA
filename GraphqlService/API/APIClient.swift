//
//  APIClient.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import ComposableArchitecture
import GraphqlAPI

@DependencyClient
struct APIClient {
    var paginatedCharacters: @Sendable (_ page: Int) async throws -> PaginatedResult?
    var character: @Sendable (_ id: String) async throws -> CharacterAttrs?

}

extension APIClient: TestDependencyKey {
    
//  static let previewValue = Self(
//    paginatedCharacters: {_ in
//        return .init(next: 1, total: 1, data: [.init(id: "1", name: "Test name", type: "Type")])
//    },
//    character: {_ in
//        return .init(name: "Test", type: "type", gender: "gender", image: nil, id: "1", status: "status", species: "species")
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
    },
    character: {
        return try await APIService.character(id: $0)
    }
  )
}
