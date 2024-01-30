//
//  DetailsStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import ComposableArchitecture

@Reducer
struct DetailsStore {
    struct State: Codable, Equatable, Hashable {
        let id: Int
        var isLoading = false
    }
    
    enum Action {
        case fetchPersonDetails
        case fetchEpisodes
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .fetchPersonDetails:
                print("fetchPersonDetails")
                return .none
            case .fetchEpisodes:
                print("fetchEpisodes")
                return .none
            }
        }
    }
}
