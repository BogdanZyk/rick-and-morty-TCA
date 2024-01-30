//
//  FavoriteButton.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct FavoriteButton<ID: Hashable & Sendable>: View {
  let store: Store<FavoritingState<ID>, FavoritingAction>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      Button {
        viewStore.send(.buttonTapped)
      } label: {
        Image(systemName: "heart")
          .symbolVariant(viewStore.isFavorite ? .fill : .none)
      }
      .alert(store: self.store.scope(state: \.$alert, action: \.alert))
    }
  }
}

#Preview {
 
    @Sendable func favorite<ID>(id: ID, isFavorite: Bool) async throws -> Bool {
        try await Task.sleep(for: .seconds(1))
        if .random(in: 0...1) > 0.25 {
            return isFavorite
        } else {
            throw FavoriteError()
        }
    }
    
    return FavoriteButton<String>(store: .init(initialState: FavoritingState(id: "1", isFavorite: false), reducer: {
          FavoritingStore(favorite: favorite(id:isFavorite:))
      }))
}



struct FavoriteError: LocalizedError, Equatable {
  var errorDescription: String? {
    "Favoriting failed."
  }
}
