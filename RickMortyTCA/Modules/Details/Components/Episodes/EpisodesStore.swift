//
//  EpisodesStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import ComposableArchitecture
import GraphqlAPI

@Reducer
struct EpisodesStore {
    
    @Dependency(\.apiClient) var apiClient
    
    struct State: Equatable, Hashable {
        let id: String
        var episodes: [String] = []
    }
    
    enum Action {
        case fetch
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .fetch:
                state.episodes = (0...10).map({"\($0)"})
                return .none
            }
        }
    }
}
