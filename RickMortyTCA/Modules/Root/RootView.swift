//
//  RootView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    @State private var store = Store(initialState: RootStore.State()) {
        RootStore()
    }
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: \.path)) {
            WithViewStore(store, observe: {$0}) { viewStore in
                TabView(selection: viewStore.binding(get: \.selectedTab, send: RootStore.Action.tabSelected)) {
                    makeRootView()
                }
            }
        } destination: {
            switch $0 {
            case .details:
                CaseLet(
                    \RootStore.Path.State.details,
                     action: RootStore.Path.Action.details,
                     then: PersonDetails.init(store:)
                )
            }
        }
    }
}

#Preview {
    RootView()
}

extension RootView {
    
    @ViewBuilder
    private func makeRootView() -> some View {
        HomeView()
            .tag(RootStore.Tab.home)
            .tabItem { Text("Home") }
        SearchView()
            .tag(RootStore.Tab.search)
            .tabItem { Text("Search") }
        ProfileView()
            .tag(RootStore.Tab.profile)
            .tabItem { Text("Profile") }
    }
    
}
