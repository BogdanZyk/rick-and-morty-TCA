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
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { proxy in
                    NukeImage(strUrl: viewStore.character.image,
                              resizeSize: .init(width: proxy.size.width, height: proxy.size.height),
                              contentMode: .aspectFill,
                              crop: true)
                }
                
                VStack(alignment: .leading) {
                    Text(viewStore.character.name ?? "")
                        .bold()
                    Text(viewStore.character.type ?? "")
                        .foregroundStyle(.secondary)
                }
                .font(.callout)
                .lineLimit(1)
                .padding(10)
            }
            .allFrame()
            .frame(height: getRect().height / 3)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(alignment: .topTrailing) {
                FavoriteButton(store: self.store.scope(state: \.favorite, action: \.favorite))
                    .padding()
            }
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
    CharacterList(store: .init(initialState: CharactersStore.State(), reducer: {
        CharactersStore()
    }, withDependencies: {
        $0.apiClient = .testValue
    }))
//    CharacterRow(store: .init(initialState: CharacterStore.State(character: .mock), reducer: {
//        CharacterStore(favorite: {_,_ in false})
//    }), onTap: {_ in})
}
