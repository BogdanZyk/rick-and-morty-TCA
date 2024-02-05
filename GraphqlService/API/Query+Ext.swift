//
//  Query+Ext.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 05.02.2024.
//

import GraphqlAPI

protocol Searchable: Identifiable {
    var searchItem: SearchItem { get }
}

extension PaginatedCharacter: Searchable {
    
    static let mock: Self = .init(id: "1", name: "Test name", type: "Type")
    
    static let mock2: Self = .init(id: "2", name: "Test name 2", type: "Type 2")
    
    var searchItem: SearchItem {
        .init(id: id, title: name, subtitle: type, image: image, type: .characters)
    }
}

extension PaginatedEpisodes: Searchable {
    
    static let mock: Self = .init(id: "1", name: "Episode 1", air_date: "date", episode: "S01E01", characters: [.init(id: "1", name: "Rick")])
    
    static let mock2: Self = .init(id: "2", name: "Episode 2", air_date: "date", episode: "S01E02", characters: [.init(id: "1", name: "Rick")])
    
    var searchItem: SearchItem {
        .init(id: id, title: name, subtitle: episode, image: nil, type: .episodes)
    }
}

extension PaginatedLocation: Searchable {
    
    static let mock: Self = .init(id: "1", name: "Location name 1", type: "type", dimension: "dimension", residents: [.init(id: "1", name: "Rick")])
    
    static let mock2: Self = .init(id: "2", name: "Location name 2", type: "type", dimension: "dimension", residents: [.init(id: "1", name: "Rick")])
    
    var searchItem: SearchItem {
        .init(id: id, title: name, subtitle: dimension, image: nil, type: .location)
    }
}

extension CharacterAttrs {

    static let mock: Self = .init(name: "Test", type: "type", gender: "gender", image: nil, id: "1", status: "status", species: "species")
}
