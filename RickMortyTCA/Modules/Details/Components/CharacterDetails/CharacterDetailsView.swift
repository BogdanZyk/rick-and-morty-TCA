//
//  CharacterDetailsView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 01.02.2024.
//

import SwiftUI
import ComposableArchitecture

struct CharacterDetailsView: View {
    let store: StoreOf<CharacterDetailsStore>
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            if let details = viewStore.personDetails {
                VStack {
                    Text(details.name ?? "")
                    Text(details.type ?? "")
                    Text(details.gender ?? "")
                }
            } else {
                ProgressView()
            }
        }
        .task {
            store.send(.fetch)
        }
    }
}

#Preview {
    CharacterDetailsView(store: .init(initialState: CharacterDetailsStore.State.init(id: "1"), reducer: {
        CharacterDetailsStore()
    }))
}
