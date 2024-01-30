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
    
}


typealias PaginatedResult = (next: Int, data: [PaginatedCharacter])

struct APIService: APIProvider {
    
    private static let client = Network.shared.client
    
    static func paginatedCharacters(page: Int) async throws -> PaginatedResult? {
        
        let query = PaginatedCharactersQuery(page: .init(integerLiteral: page), filter: .null)
        
        guard let result = try await client.fetch(query: query),
              let next = result.data?.characters?.info?.next,
              let data = result.data?.characters?.results?.compactMap({$0?.fragments.paginatedCharacter}) else {
            return nil
        }
        
        return (next, data)
    }
    
}


extension PaginatedCharacter: Identifiable {}
