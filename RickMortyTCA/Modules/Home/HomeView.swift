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
    var rootStore: StoreOf<RootStore>?
    @State private var store = Store(initialState: HomeStore.State()) {
        HomeStore()
    }

    var body: some View {
        CharacterList(rootStore: rootStore, store: store.scope(state: \.charactersStore, action: \.charactersStore))
    }
}

#Preview {
    HomeView()
}


extension HomeView {
    
    struct CharacterList: View {
        @State private var isLoad: Bool = true
        var rootStore: StoreOf<RootStore>?
        let store: StoreOf<CharactersStore>
        var body: some View {
            WithViewStore(store, observe: {$0}) { viewStore in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 10){
                        
                        ForEachStore(self.store.scope(state: \.characters, action: \.characters)) { rowStore in
                            CharacterRow(store: rowStore) {
                                rootStore?.send(.navigate(.details(.init(id: $0))))
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
}
