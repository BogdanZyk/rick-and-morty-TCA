//
//  EpisodesStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import ComposableArchitecture
import GraphqlAPI

@Reducer
struct EpisodesStore {
    
    @Dependency(\.apiClient) var client
    
    struct State: Equatable {
        var episodes = [PaginatedEpisodes]()
        var total: Int = 1
        var next: Int = 0
    }
    
    enum Action {
        case fetch
        case onAppear
        case handleResult(PaginatedResult<PaginatedEpisodes>?)
        case fetchNextPage(String?)
        case refetch
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if !state.episodes.isEmpty { return .none }
                return .run { send in
                    await send(.fetch)
                }
                
            case .fetch:
                return .run { [page = state.next] send in
                    let result = try await client.episodes(page: page)
                    await send(.handleResult(result), animation: .default)
                }
                
            case let .handleResult(result):
                guard let result else { return .none}
                state.episodes.append(contentsOf: result.data)
                state.next = result.next
                state.total = result.total
                return .none
                
            case let .fetchNextPage(id):
                if id != state.episodes.last?.id, state.total >= (state.next - 1) { return .none }
                return .run { send in
                    await send(.fetch)
                }
            case .refetch:
                state.episodes = []
                state.next = 0
                return .run { send in
                    await send(.fetch)
                }
            }
        }
    }
}
