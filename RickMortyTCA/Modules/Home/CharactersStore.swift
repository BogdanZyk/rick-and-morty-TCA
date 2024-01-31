//
//  CharactersStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import GraphqlAPI
import ComposableArchitecture

@Reducer
struct CharactersStore {
    
    @Dependency(\.apiClient) var client
    
    struct State: Equatable {
        var characters: IdentifiedArrayOf<CharacterStore.State> = []
        var total: Int = 1
        var next: Int = 0
    }
    
    enum Action {
        case characters(IdentifiedActionOf<CharacterStore>)
        case fetch
        case onAppear
        case handleResult(PaginatedResult?)
        case fetchNextPage(String?)
        case refetch
    }
    
    @Sendable func favorite<ID>(id: ID, isFavorite: Bool) async throws -> Bool {
        try await Task.sleep(for: .seconds(1))
        if .random(in: 0...1) > 0.25 {
            return isFavorite
        } else {
            throw FavoriteError()
        }
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
                let characters = result.data.compactMap({CharacterStore.State(character: $0)})
                state.characters.append(contentsOf: characters)
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
            case let .characters(.element(id: _, action: .onAppear(id))):
                return .run { send in
                    await send(.fetchNextPage(id))
                }
            case .characters:
                return .none
            }
        }
        .forEach(\.characters, action: \.characters) {
            CharacterStore(favorite: self.favorite)
        }
    }
}


@Reducer
struct CharacterStore {
    struct State: Equatable, Identifiable {
        var alert: AlertState<FavoritingAction.Alert>?
        var id: String { character.id ?? "1" }
        var isFavorite: Bool = false
        let character: PaginatedCharacter
        
        var favorite: FavoritingState<ID> {
            get { .init(alert: self.alert, id: self.id, isFavorite: self.isFavorite) }
            set { (self.alert, self.isFavorite) = (newValue.alert, newValue.isFavorite) }
        }
    }
    
    enum Action {
        case favorite(FavoritingAction)
        case onAppear(String)
    }
    
    let favorite: @Sendable (String, Bool) async throws -> Bool
    
    var body: some Reducer<State, Action> {
        Scope(state: \.favorite, action: \.favorite) {
            FavoritingStore(favorite: self.favorite)
        }
    }
}
