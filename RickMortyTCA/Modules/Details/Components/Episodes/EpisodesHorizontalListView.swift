//
//  EpisodesHorizontalListView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 01.02.2024.
//

import SwiftUI
import ComposableArchitecture

struct EpisodesHorizontalListView: View {
    let store: StoreOf<EpisodesListStore>
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewStore.episodes, id: \.self) { count in
                        VStack {
                            Text("item \(count)")
                        }
                        .allFrame()
                        .frame(width: getRect().width / 1.5)
                        .background(Color.secondary.opacity(0.5), in: RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 180)
        }
        .task {
            store.send(.fetch)
        }
    }
}

#Preview {
    EpisodesHorizontalListView(store: .init(initialState: EpisodesListStore.State(id: "1"), reducer: {
        EpisodesListStore()
    }))
}
