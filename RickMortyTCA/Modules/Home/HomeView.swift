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
    var body: some View {
        VStack {
            Button(action: {
                rootStore?.send(.navigate(.details(.init(id: 123))))
            }, label: {
                Text("Details")
            })
        }
        .task {
            store.send(.onAppear)
        }
    }
}

#Preview {
    HomeView()
}
