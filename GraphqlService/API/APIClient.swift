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
    var paginatedCharacters: @Sendable (_ page: Int) async throws -> PaginatedResult<PaginatedCharacter>?
    var character: @Sendable (_ id: String) async throws -> CharacterAttrs?
    var searchCharacters: @Sendable (_ query: String) async throws -> [PaginatedCharacter]
    var favorite:  @Sendable (_ id: String, _ isFavorite: Bool) async throws -> Bool
    var episodes: @Sendable (_ page: Int) async throws -> PaginatedResult<PaginatedEpisodes>?
    var searchEpisodes: @Sendable (_ query: String) async throws -> [PaginatedEpisodes]
    var locations: @Sendable (_ page: Int) async throws -> PaginatedResult<PaginatedLocation>?
    var searchLocations: @Sendable (_ query: String) async throws -> [PaginatedLocation]
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
        },
        episodes: {
            try await APIService.paginatedEpisodes(page: $0)
        },
        searchEpisodes: {
            try await APIService.searchEpisodes(query: $0)
        },
        locations: {
            try await APIService.paginatedLocations(page: $0)
        },
        searchLocations: {
            try await APIService.searchLocation(query: $0)
        }
    )
}

extension APIClient: TestDependencyKey {
        
    static let testValue = Self(
        paginatedCharacters: {
            if $0 >= 1 {
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
        },
        episodes: {
            if $0 >= 1 {
                return .init(next: 2, total: 2, data: [PaginatedEpisodes.mock])
            }
            return .init(next: 1, total: 2, data: [PaginatedEpisodes.mock2])
        },
        searchEpisodes: { _ in
            [PaginatedEpisodes.mock, .mock2]
        },
        locations: {
            if $0 >= 1 {
                return .init(next: 2, total: 2, data: [PaginatedLocation.mock])
            }
            return .init(next: 1, total: 2, data: [PaginatedLocation.mock2])
        },
        searchLocations: { _ in
            [PaginatedLocation.mock, .mock2]
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

extension PaginatedEpisodes {
    
    static let mock: Self = .init(id: "1", name: "Episode name", air_date: "date", episode: "Episode", characters: [.init(id: "1", name: "Rick")])
    
    static let mock2: Self = .init(id: "2", name: "Episode name 2", air_date: "date", episode: "Episode", characters: [.init(id: "1", name: "Rick")])
    
}

extension PaginatedLocation {
    
    static let mock: Self = .init(id: "1", name: "Location name 1", type: "type", dimension: "dimension", residents: [.init(id: "1", name: "Rick")])
    
    static let mock2: Self = .init(id: "2", name: "Location name 2", type: "type", dimension: "dimension", residents: [.init(id: "1", name: "Rick")])
}
