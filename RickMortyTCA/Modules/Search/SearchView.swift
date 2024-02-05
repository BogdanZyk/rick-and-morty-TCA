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
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(store.results) {
                        rowView($0)
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
    SearchView(store: .init(initialState: SearchStore.State(type: .characters), reducer: {
        SearchStore()
    }, withDependencies: {
        $0.apiClient = .testValue
    }))
}


extension SearchView {
    
    private func rowView(_ item: SearchItem) -> some View {
        HStack(alignment: .top) {
            if let image = item.image {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 60, height: 60)
            }
            VStack(alignment: .leading) {
                Text(item.title ?? "")
                    .bold()
                Text(item.subtitle ?? "")
            }
            .padding(.top, 5)
            .font(.callout)
        }
        .hLeading()
        .padding(.vertical, 10)
        .contentShape(Rectangle())
        .onTapGesture {
            guard let id = item.id else { return }
            switch item.type {
                
            case .characters:
                rootStore?.send(.navigate(.details(.init(id: id))))
            case .episodes:
                return
            case .location:
                return
            }
        }
    }
    
}
