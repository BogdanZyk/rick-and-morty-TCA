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
                TabView(selection: viewStore.binding(get: \.tab.selectedTab, send: { RootStore.Action.tab(.tabSelected($0))} )) {
                    makeRootView()
                }
            }
        } destination: {
            makeDestination($0)
        }
    }
}

#Preview {
    RootView()
}

extension RootView {
    
    @ViewBuilder
    private func makeRootView() -> some View {
        HomeView(store: store.scope(state: \.tab.home, action: \.tab.home))
            .tag(TabStore.Tab.home)
            .tabItem { Text("Home") }
        EpisodesView(store: store.scope(state: \.tab.episodes, action: \.tab.episodes))
            .tag(TabStore.Tab.episodes)
            .tabItem { Text("Profile") }
    }
    
    
    private func makeDestination(_ type: RootStore.Path.State) -> some View {
        switch type {
        case .details:
            CaseLet(
                \RootStore.Path.State.details,
                 action: RootStore.Path.Action.details) {
                     PersonDetails.init(store:$0)
                 }
        }
    }
}
