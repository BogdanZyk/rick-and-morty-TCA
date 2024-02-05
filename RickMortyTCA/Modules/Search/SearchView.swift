//
//  SearchView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    @FocusState private var isFocus: Bool
    var rootStore: StoreOf<RootStore>?
    @Bindable var store: StoreOf<SearchStore>
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(
                    "Search", text: $store.searchQuery.sending(\.searchQueryChanged)
                )
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .focused($isFocus)
            }
            .padding(.horizontal, 16)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if store.type == .characters {
                        charactersList
                    } else {
                        episodesList
                    }
                }
                .padding()
            }
            .overlay {
                if store.loader {
                    ProgressView()
                }
            }
        }
        .onChange(of: store.searchQuery) {_, _ in
            Task {
                try await Task.sleep(for: .milliseconds(300))
                await store.send(.searchQueryChangeDebounced).finish()
            }
        }
        .toolbarTitleDisplayMode(.inline)
        .task {
            try? await Task.sleep(for: .milliseconds(400))
            isFocus = true
        }
    }
}

#Preview {
    SearchView(store: .init(initialState: SearchStore.State(), reducer: {
        SearchStore()
    }))
}


extension SearchView {
    
    private var charactersList: some View {
        ForEachStore(self.store.scope(state: \.characters, action: \.characters)) { rowStore in
            CharacterRow(store: rowStore) {
                rootStore?.send(.navigate(.details(.init(id: $0))))
            }
        }
    }
    
    private var episodesList: some View {
        ForEachStore(self.store.scope(state: \.episodes, action: \.episodes)) { rowStore in
            CharacterRow(store: rowStore) {
                rootStore?.send(.navigate(.details(.init(id: $0))))
            }
        }
    }
}
