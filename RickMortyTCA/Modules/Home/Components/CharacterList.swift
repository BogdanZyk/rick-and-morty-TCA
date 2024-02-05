//
//  CharacterList.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 05.02.2024.
//

import SwiftUI
import ComposableArchitecture

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

#Preview {
    CharacterList(store: .init(initialState: CharactersStore.State(), reducer: {
        CharactersStore()
    }, withDependencies: {
        $0.apiClient = .testValue
    }))
}
