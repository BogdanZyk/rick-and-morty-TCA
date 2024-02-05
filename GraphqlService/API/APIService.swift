//
//  APIService.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import GraphqlAPI

protocol APIProvider {
    
    static func paginatedCharacters(page: Int) async throws -> PaginatedResult<PaginatedCharacter>?
    
    static func character(id: String) async throws -> CharacterAttrs?
    
    static func searchCharacters(query: String) async throws -> [PaginatedCharacter]
    
    static func favorite(id: String, isFavorite: Bool) async throws -> Bool
    
    static func paginatedLocations(page: Int) async throws -> PaginatedResult<PaginatedLocation>?
    
    static func searchLocation(query: String) async throws -> [PaginatedLocation]
    
    static func paginatedEpisodes(page: Int) async throws -> PaginatedResult<PaginatedEpisodes>?
    
    static func searchEpisodes(query: String) async throws -> [PaginatedEpisodes]
}

struct APIService: APIProvider {
   
    private static let client = Network.shared.client
    
    static func paginatedCharacters(page: Int) async throws -> PaginatedResult<PaginatedCharacter>? {
        
        let query = PaginatedCharactersQuery(page: .init(integerLiteral: page), filter: .null)
        
        guard let result = try await client.fetch(query: query),
              let next = result.data?.characters?.info?.next,
              let total = result.data?.characters?.info?.pages,
              let data = result.data?.characters?.results?.compactMap({$0?.fragments.paginatedCharacter}) else {
            return nil
        }
        
        return .init(next: next, total: total, data: data)
    }
    
    static func character(id: String) async throws -> CharacterAttrs? {
        let query = CharacterQuery(characterId: id)
        return try await client.fetch(query: query)?.data?.character?.fragments.characterAttrs
    }
    
    static func searchCharacters(query: String) async throws -> [PaginatedCharacter] {
        let query = PaginatedCharactersQuery(page: .null, filter: .init(.init(name: .init(stringLiteral: query))))
        return try await client.fetch(query: query)?.data?.characters?.results?.compactMap({$0?.fragments.paginatedCharacter}) ?? []
    }
    
    static func paginatedLocations(page: Int) async throws -> PaginatedResult<PaginatedLocation>? {
        
        let query = PaginatedLocationsQuery(page: .init(integerLiteral: page), filter: .null)
        
        guard let result = try await client.fetch(query: query),
              let next = result.data?.locations?.info?.next,
              let total = result.data?.locations?.info?.pages,
              let data = result.data?.locations?.results?.compactMap({$0?.fragments.paginatedLocation}) else {
            return nil
        }
        
        return .init(next: next, total: total, data: data)
    }
    
    static func searchLocation(query: String) async throws -> [PaginatedLocation] {
        let query = PaginatedLocationsQuery(page: .null, filter: .init(.init(name: .init(stringLiteral: query))))
        return try await client.fetch(query: query)?.data?.locations?.results?.compactMap({$0?.fragments.paginatedLocation}) ?? []
    }
    
    static func paginatedEpisodes(page: Int) async throws -> PaginatedResult<PaginatedEpisodes>? {
        let query = PaginatedEpisodesQuery(page: .init(integerLiteral: page), filter: .null)
        
        guard let result = try await client.fetch(query: query),
              let next = result.data?.episodes?.info?.next,
              let total = result.data?.episodes?.info?.pages,
              let data = result.data?.episodes?.results?.compactMap({$0?.fragments.paginatedEpisodes}) else {
            return nil
        }
        
        return .init(next: next, total: total, data: data)
    }
    
    static func searchEpisodes(query: String) async throws -> [PaginatedEpisodes] {
        let query = PaginatedEpisodesQuery(page: .null, filter: .init(.init(name: .init(stringLiteral: query))))
        return try await client.fetch(query: query)?.data?.episodes?.results?.compactMap({$0?.fragments.paginatedEpisodes}) ?? []
    }
    
    static func favorite(id: String, isFavorite: Bool) async throws -> Bool {
        try await Task.sleep(for: .seconds(1))
        if .random(in: 0...1) > 0.25 {
            return isFavorite
        } else {
            throw FavoriteError()
        }
    }
}


struct PaginatedResult<T: Identifiable> {
    
    var next: Int = 1
    var total: Int = 1
    var data: [T] = []
    
    var isNextPage: Bool {
        total > next
    }
}
