//
//  CharactersView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import GraphqlAPI
import ComposableArchitecture

struct CharactersView: View {
    let store: StoreOf<HomeStore>

    var body: some View {
        VStack(spacing: 0) {
            CharacterList(store: store.scope(state: \.charactersStore, action: \.charactersStore))
        }
    }
}

#Preview {
    CharactersView(store: .init(initialState: HomeStore.State(), reducer: {
        HomeStore()
    }, withDependencies: {
        $0.apiClient = .testValue
    }))
}
