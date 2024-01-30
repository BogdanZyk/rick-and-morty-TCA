//
//  HomeView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    @State private var store = Store(initialState: HomeStore.State()) {
        HomeStore()
    }
    var body: some View {
        VStack {
            NavigationLink(
              "Details",
              state: RootStore.Path.State.details(.init(id: 123))
            )
        }
    }
}

#Preview {
    HomeView()
}
