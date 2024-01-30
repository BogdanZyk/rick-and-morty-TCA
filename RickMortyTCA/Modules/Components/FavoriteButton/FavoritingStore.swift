//
//  FavoritingStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import ComposableArchitecture

struct FavoritingState<ID: Hashable & Sendable>: Equatable {
    @PresentationState var alert: AlertState<FavoritingAction.Alert>?
    let id: ID
    var isFavorite: Bool
}

@CasePathable
enum FavoritingAction {
    case alert(PresentationAction<Alert>)
    case buttonTapped
    case response(Result<Bool, Error>)
    
    enum Alert: Equatable {}
}

@Reducer
struct FavoritingStore<ID: Hashable & Sendable> {
    
    let favorite: @Sendable (ID, Bool) async throws -> Bool
    
    private struct CancelID: Hashable {
        let id: AnyHashable
    }
    
    var body: some Reducer<FavoritingState<ID>, FavoritingAction> {
        Reduce { state, action in
            switch action {
            case .alert(.dismiss):
                state.alert = nil
                state.isFavorite.toggle()
                return .none
                
            case .buttonTapped:
                state.isFavorite.toggle()
                
                return .run { [id = state.id, isFavorite = state.isFavorite, favorite] send in
                    await send(.response(Result { try await favorite(id, isFavorite) }))
                }
                .cancellable(id: CancelID(id: state.id), cancelInFlight: true)
                
            case let .response(.failure(error)):
                state.alert = AlertState { TextState(error.localizedDescription) }
                return .none
                
            case let .response(.success(isFavorite)):
                state.isFavorite = isFavorite
                return .none
            }
        }
    }
}
