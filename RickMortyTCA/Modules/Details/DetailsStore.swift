//
//  DetailsStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import ComposableArchitecture
import GraphqlAPI

@Reducer
struct DetailsStore {
    
    struct State: Equatable, Hashable {
        let id: String
        var personDetails: CharacterAttrs?
    }
    
    enum Action {
        case fetchPersonDetails
        case fetchEpisodes
        case handlePersonResult(CharacterAttrs?)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.apiClient) var apiClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .fetchPersonDetails:
                return .run { [id = state.id] send in
                    let result = try await apiClient.character(id: id)
                    await send(.handlePersonResult(result))
                }
            case let .handlePersonResult(result):
                state.personDetails = result
                return .none
            case .fetchEpisodes:
                print("fetchEpisodes")
                return .none
            }
        }
    }
}
