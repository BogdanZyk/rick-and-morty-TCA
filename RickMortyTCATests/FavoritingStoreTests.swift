//
//  FavoritingStoreTests.swift
//  RickMortyTCATests
//
//  Created by Bogdan Zykov on 31.01.2024.
//

import XCTest
import ComposableArchitecture
import GraphqlAPI
@testable import RickMortyTCA

@MainActor
final class FavoritingStoreTests: XCTestCase {

    func test_toggleFavoriteAction() async {
        
        let store = TestStore(initialState: CharacterStore.State(isFavorite: false, character: .mock)) {
            CharacterStore(
            favorite: { _, isFavorite in
              return isFavorite
            }
          )
        }
        
        await store.send(.favorite(.buttonTapped)) {
            $0.isFavorite = true
        }
        
        await store.receive(\.favorite.response.success)
        
        await store.send(.favorite(.buttonTapped)) {
            $0.isFavorite = false
        }
        
        await store.receive(\.favorite.response.success)
    }

    func test_favoriteFailedAction() async {
        
        let store = TestStore(initialState: CharacterStore.State(isFavorite: false, character: .mock)) {
            CharacterStore(
            favorite: { _, _ in
                throw FavoriteError()
            }
          )
        }
        
        await store.send(.favorite(.buttonTapped)) {
            $0.isFavorite = true
        }
        
        await store.receive(\.favorite.response.failure) {
            $0.alert = AlertState<FavoritingAction.Alert> {
                TextState("Favoriting failed.")
            }
        }
        
        await store.send(.favorite(.alert(.dismiss))) {
            $0.alert = nil
            $0.isFavorite = false
        }
    }
}
