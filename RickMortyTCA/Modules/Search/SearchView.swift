//
//  SearchView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    var rootStore: StoreOf<RootStore>?
    @State private var store = Store(initialState: SearchStore.State()) {
        SearchStore()
    }
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
    }
}

#Preview {
    SearchView()
}
