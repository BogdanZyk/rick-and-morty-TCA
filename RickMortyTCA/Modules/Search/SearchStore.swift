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
        var results = [SearchItem]()
        var searchQuery = ""
        var loader: Bool = false
    }
    
    private enum CancelID { case cancel }
    
    enum Action {
        case searchQueryChanged(String)
        case searchQueryChangeDebounced
        case searchResponse(Result<[SearchItem], Error>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .searchResponse(.failure):
                state.loader = false
                return .none
            case let .searchResponse(.success(items)):
                state.loader = false
                state.results = items
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
                    state.results = []
                    state.loader = false
                    return .cancel(id: CancelID.cancel)
                }
                return .none
            }
        }
    }
    
    enum SearchType {
        
        case characters, episodes, locations
        
        func getResult(_ apiClient: APIClient, query: String) async -> Result<[SearchItem], Error> {
            
            switch self {
            case .characters:
                return await Result {
                   let result = try await apiClient.searchCharacters(query: query)
                    return result.compactMap({$0.searchItem})
                }
            case .episodes:
                return await Result {
                    let result = try await apiClient.searchEpisodes(query: query)
                    return result.compactMap({$0.searchItem})
                }
            case .locations:
                return await Result {
                    let result = try await apiClient.searchLocations(query: query)
                    return result.compactMap({$0.searchItem})
                }
            }
        }
    }
}

struct SearchItem: Identifiable, Hashable {
    
    var id: String? = UUID().uuidString
    var title: String?
    var subtitle: String?
    var image: String?
    var type: SearchStore.SearchType
    
}
