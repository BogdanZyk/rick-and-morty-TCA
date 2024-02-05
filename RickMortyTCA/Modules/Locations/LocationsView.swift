//
//  LocationsView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 02.02.2024.
//

import SwiftUI
import ComposableArchitecture

struct LocationsView: View {
    var rootStore: StoreOf<RootStore>?
    @State private var isLoad: Bool = true
    let store: StoreOf<LocationsStore>
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(viewStore.locations) { item in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(item.name ?? "").bold()
                                Text(item.type ?? "")
                                    .fontWeight(.light)
                            }
                            Text(item.dimension ?? "")
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
    LocationsView(store: .init(initialState: LocationsStore.State(), reducer: {
        LocationsStore()
    }))
}
