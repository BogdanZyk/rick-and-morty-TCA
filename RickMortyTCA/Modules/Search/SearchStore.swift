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
        var type: SearchType = .characters
        var episodes: IdentifiedArrayOf<CharacterStore.State> = []
        var characters: IdentifiedArrayOf<CharacterStore.State> = []
        var searchQuery = ""
        var loader: Bool = false
    }
    
    private enum CancelID { case cancel }
    
    enum Action {
        case searchQueryChanged(String)
        case searchQueryChangeDebounced
        case searchResponse(Result<[any Identifiable], Error>)
        case characters(IdentifiedActionOf<CharacterStore>)
        case episodes(IdentifiedActionOf<CharacterStore>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .searchResponse(.failure):
                state.loader = false
                return .none
            case let .searchResponse(.success(items)):
                state.loader = false
                
                if state.type == .characters {
                    let charactersStates = items.compactMap({$0 as? PaginatedCharacter}).map({CharacterStore.State(character: $0)})
                    state.characters = .init(uniqueElements: charactersStates)
                }
                
                return .none
                
            case .searchQueryChangeDebounced:
                guard !state.searchQuery.isEmpty else {
                    return .none
                }
                state.loader = true
                return .run { [query = state.searchQuery, type = state.type] send in
                    let result = await type.getResult(self.apiClient, query: query)
                    await send(.searchResponse(result), animation: .easeInOut)
                }
                .cancellable(id: CancelID.cancel)
                
            case let .searchQueryChanged(query):
                state.searchQuery = query
                guard !state.searchQuery.isEmpty else {
                    state.episodes = []
                    state.characters = []
                    state.loader = false
                    return .cancel(id: CancelID.cancel)
                }
                return .none
            case .characters:
                return .none
            case .episodes:
                return .none
            }
        }
        .forEach(\.characters, action: \.characters) {
            CharacterStore(favorite: apiClient.favorite)
        }
        .forEach(\.episodes, action: \.episodes) {
            CharacterStore(favorite: apiClient.favorite)
        }
    }
    
    enum SearchType {
        
        case characters, episodes
        
        func getResult(_ apiClient: APIClient, query: String) async -> Result<[any Identifiable], Error> {
            
            switch self {
            case .characters:
                return await Result {
                    try await apiClient.searchCharacters(query: query)
                }
            case .episodes:
                return await Result {
                    try await apiClient.searchCharacters(query: query)
                }
            }
        }
    }
}

