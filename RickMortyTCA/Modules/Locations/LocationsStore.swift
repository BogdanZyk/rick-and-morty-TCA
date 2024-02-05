//
//  LocationsStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 02.02.2024.
//

import Foundation
import ComposableArchitecture
import GraphqlAPI

@Reducer
struct LocationsStore {
    
    @Dependency(\.apiClient) var client
    
    struct State: Equatable {
        var locations = [PaginatedLocation]()
        var total: Int = 1
        var next: Int = 0
    }
    
    enum Action {
        case fetch
        case onAppear
        case handleResult(PaginatedResult<PaginatedLocation>?)
        case fetchNextPage(String?)
        case refetch
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if !state.locations.isEmpty { return .none }
                return .run { send in
                    await send(.fetch)
                }
                
            case .fetch:
                return .run { [page = state.next] send in
                    let result = try await client.locations(page: page)
                    await send(.handleResult(result), animation: .default)
                }
                
            case let .handleResult(result):
                guard let result else { return .none}
                state.locations.append(contentsOf: result.data)
                state.next = result.next
                state.total = result.total
                return .none
                
            case let .fetchNextPage(id):
                if id != state.locations.last?.id, state.total >= (state.next - 1) { return .none }
                return .run { send in
                    await send(.fetch)
                }
            case .refetch:
                state.locations = []
                state.next = 0
                return .run { send in
                    await send(.fetch)
                }
            }
        }
    }
}
