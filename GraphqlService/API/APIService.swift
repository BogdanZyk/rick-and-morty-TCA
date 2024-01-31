//
//  APIService.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import GraphqlAPI

protocol APIProvider {
    
    static func paginatedCharacters(page: Int) async throws -> PaginatedResult?
    
    static func character(id: String) async throws -> CharacterAttrs?
    
    static func searchCharacters(query: String) async throws -> [PaginatedCharacter]
    
    static func favorite(id: String, isFavorite: Bool) async throws -> Bool
}

struct APIService: APIProvider {
   
    private static let client = Network.shared.client
    
    static func paginatedCharacters(page: Int) async throws -> PaginatedResult? {
        
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
    
    static func favorite(id: String, isFavorite: Bool) async throws -> Bool {
        try await Task.sleep(for: .seconds(1))
        if .random(in: 0...1) > 0.25 {
            return isFavorite
        } else {
            throw FavoriteError()
        }
    }
}


struct PaginatedResult: Equatable {
    
    var next: Int = 1
    var total: Int = 1
    var data: [PaginatedCharacter] = []
    
    var isNextPage: Bool {
        total > next
    }
}


extension PaginatedCharacter: Identifiable {}
