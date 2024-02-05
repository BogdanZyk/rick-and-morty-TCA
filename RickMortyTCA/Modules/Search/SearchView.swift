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
                    ForEachStore(self.store.scope(state: \.results, action: \.characters)) { rowStore in
                        CharacterRow(store: rowStore) {
                            rootStore?.send(.navigate(.details(.init(id: $0))))
                        }
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
