//
//  Network.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import ApolloAPI
import Apollo


class Network {
    
    static let shared = Network()
    
    private init() { }
    
    private(set) lazy var client: ApolloClient = {
        let url = URL(string: "https://rickandmortyapi.com/graphql")!
        return ApolloClient(url: url)
    }()
}
