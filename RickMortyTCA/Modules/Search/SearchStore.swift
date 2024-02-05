//
//  SearchStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import ComposableArchitecture
import GraphqlAPI

@Reducer
struct SearchStore {
    
    @Dependency(\.apiClient) private var apiClient
    
    @ObservableState
    struct State: Equatable, Hashable {
        var results: IdentifiedArrayOf<CharacterStore.State> = []
        var searchQuery = ""
        var loader: Bool = false
    }
    
    private enum CancelID { case cancel }
    
    enum Action {
        case searchQueryChanged(String)
        case searchQueryChangeDebounced
        case searchResponse(Result<[PaginatedCharacter], Error>)
        case characters(IdentifiedActionOf<CharacterStore>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .searchResponse(.failure):
                state.loader = false
                return .none
            case let .searchResponse(.success(characters)):
                state.loader = false
                let charactersStates = characters.compactMap({CharacterStore.State(character: $0)})
                state.results = .init(uniqueElements: charactersStates)
                return .none
                
            case .searchQueryChangeDebounced:
                guard !state.searchQuery.isEmpty else {
                    return .none
                }
                state.loader = true
                return .run { [query = state.searchQuery] send in
                    await send(.searchResponse(Result {
                        try await self.apiClient.searchCharacters(query: query)
                    }), animation: .easeInOut)
                }
                .cancellable(id: CancelID.cancel)
                
            case let .searchQueryChanged(query):
                state.searchQuery = query
                guard !state.searchQuery.isEmpty else {
                    state.results = []
                    state.loader = false
                    return .cancel(id: CancelID.cancel)
                }
                return .none
            case .characters(_):
                return .none
            }
        }
        .forEach(\.results, action: \.characters) {
            CharacterStore(favorite: apiClient.favorite)
        }
    }
}
