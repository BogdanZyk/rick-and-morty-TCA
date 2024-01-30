//
//  HomeStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import ComposableArchitecture
import GraphqlAPI

@Reducer
struct HomeStore {
    
    @Dependency(\.apiClient) var client
    
    struct State: Equatable{
        var characters = [PaginatedCharacter]()
        var total: Int = 1
        var next: Int = 0
    }
    
    enum Action {
        case fetch
        case onAppear
        case handleResult(PaginatedResult?)
        case fetchNextPage(String?)
        case refetch
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if !state.characters.isEmpty { return .none }
                return .run { send in
                    await send(.fetch)
                }
                
            case .fetch:
                return .run { [page = state.next] send in
                    let result = try await client.paginatedCharacters(page: page)
                    await send(.handleResult(result), animation: .default)
                }
                
            case let .handleResult(result):
                guard let result else { return .none}
                state.characters.append(contentsOf: result.data)
                state.next = result.next
                state.total = result.total
                return .none
                
            case let .fetchNextPage(id):
                if id != state.characters.last?.id, state.next < state.total { return .none }
                return .run { send in
                    await send(.fetch)
                }
            case .refetch:
                state.characters = []
                state.next = 0
                return .run { send in
                    await send(.fetch)
                }
            }
        }
        //._printChanges()
    }
}
