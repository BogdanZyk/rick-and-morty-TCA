//
//  HomeView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    var rootStore: StoreOf<RootStore>?
    @State private var store = Store(initialState: HomeStore.State()) {
        HomeStore()
    }
    @State private var isLoad: Bool = true
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 10){
                    ForEach(viewStore.characters) { character in
                        VStack(alignment: .leading) {
                            Text(character.name ?? "")
                            Text(character.type ?? "")
                        }
                        .hLeading()
                        .padding()
                        .background(Color.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
                        .onAppear {
                            viewStore.send(.fetchNextPage(character.id), animation: .default)
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

#Preview {
    HomeView()
}
