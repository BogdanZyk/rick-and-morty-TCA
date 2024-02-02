//
//  HomeView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import GraphqlAPI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<HomeStore>

    var body: some View {
        CharacterList(store: store.scope(state: \.charactersStore, action: \.charactersStore))
    }
}

#Preview {
    HomeView(store: .init(initialState: HomeStore.State(), reducer: {
        HomeStore()
    }))
}




struct CharacterList: View {
    @State private var isLoad: Bool = true
    let store: StoreOf<CharactersStore>
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 10){
                    
                    ForEachStore(self.store.scope(state: \.characters, action: \.characters)) { rowStore in
                        CharacterRow(store: rowStore) {_ in
                            rowStore.send(.onTap)
                        }
                    }
                }
                .padding()
            }
            .overlay {
                if isLoad {
                    ProgressView()
                }
            }
        }
        .task {
            await store.send(.onAppear).finish()
            isLoad = false
        }
        .refreshable {
            store.send(.refetch)
        }
    }
}

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
