//
//  CharacterDetailsStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 01.02.2024.
//

import GraphqlAPI
import ComposableArchitecture

@Reducer
struct CharacterDetailsStore {
    
    @Dependency(\.apiClient) var apiClient
    
    struct State: Equatable, Hashable {
        let id: String
        var personDetails: CharacterAttrs?
    }
    
    enum Action {
        case fetch
        case handlePersonResult(CharacterAttrs?)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .fetch:
                return .run { [id = state.id] send in
                    let result = try await apiClient.character(id: id)
                    await send(.handlePersonResult(result))
                }
                
            case let .handlePersonResult(result):
                state.personDetails = result
                return .none
            }
        }
    }
}
