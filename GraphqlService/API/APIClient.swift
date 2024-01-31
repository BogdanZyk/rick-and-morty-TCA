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
    var searchCharacters: @Sendable (_ query: String) async throws -> [PaginatedCharacter]
    var favorite:  @Sendable (_ id: String, _ isFavorite: Bool) async throws -> Bool
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
            try await APIService.paginatedCharacters(page: $0)
        },
        character: {
            try await APIService.character(id: $0)
        },
        searchCharacters: {
            try await APIService.searchCharacters(query: $0)
        },
        favorite: {
            try await APIService.favorite(id: $0, isFavorite: $1)
        }
    )
}

extension APIClient: TestDependencyKey {
    
    //  static let previewValue = Self(
    //    paginatedCharacters: {_ in
    //        return .init(next: 1, total: 1, data: [PaginatedCharacter.mock])
    //    },
    //    character: {_ in
    //        return CharacterAttrs.mock
    //    }
    //  )
    
    static let testValue = Self(
        paginatedCharacters: { next in
            if next >= 1 {
                return .init(next: 2, total: 2, data: [PaginatedCharacter.mock2])
            }
            return .init(next: 1, total: 2, data: [PaginatedCharacter.mock])
        },
        character: {_ in
            return CharacterAttrs.mock
        },
        searchCharacters: { _ in
            return []
        },
        favorite: {_, _ in
            return Bool.random()
        }
    )
}


extension PaginatedCharacter {
    
    static let mock: Self = .init(id: "1", name: "Test name", type: "Type")
    
    static let mock2: Self = .init(id: "2", name: "Test name 2", type: "Type 2")
}

extension CharacterAttrs {
    
    static let mock: Self = .init(name: "Test", type: "type", gender: "gender", image: nil, id: "1", status: "status", species: "species")
}
