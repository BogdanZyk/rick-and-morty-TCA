//
//  EpisodesView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct EpisodesView: View {
    var rootStore: StoreOf<RootStore>?
    @State private var isLoad: Bool = true
    let store: StoreOf<EpisodesStore>
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(viewStore.episodes) { item in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Episode: " + (item.episode ?? "")).bold()
                                Spacer()
                                Text(item.air_date ?? "")
                                    .fontWeight(.light)
                            }
                            Text(item.name ?? "")
                                .fontWeight(.medium)
                        }
                        .hLeading()
                        .font(.callout)
                        .padding()
                        .background(Color.secondary.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
                        .onTapGesture {
                            
                        }
                        .onAppear {
                            viewStore.send(.fetchNextPage(item.id ?? ""))
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
    EpisodesView(store: .init(initialState: EpisodesStore.State(), reducer: {
        EpisodesStore()
    }, withDependencies: {
        $0.apiClient = .testValue
    }))
}
