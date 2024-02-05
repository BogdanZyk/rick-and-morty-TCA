//
//  CharacterRow.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 05.02.2024.
//

import SwiftUI
import ComposableArchitecture

struct CharacterRow: View {
    let store: StoreOf<CharacterStore>
    let onTap: (String) -> Void
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            HStack {
                VStack(alignment: .leading) {
                    Text(viewStore.character.name ?? "")
                    Text(viewStore.character.type ?? "")
                }
                Spacer()
                FavoriteButton(store: self.store.scope(state: \.favorite, action: \.favorite))
            }
            .hLeading()
            .padding()
            .background(Color.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
            .onTapGesture {
                onTap(viewStore.id)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

#Preview {
    CharacterRow(store: .init(initialState: CharacterStore.State(character: .mock), reducer: {
        CharacterStore(favorite: {_,_ in false})
    }), onTap: {_ in})
}
