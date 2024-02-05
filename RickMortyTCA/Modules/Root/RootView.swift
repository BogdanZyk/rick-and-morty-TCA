//
//  RootView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    @State var store = Store(initialState: RootStore.State()) {
        RootStore()
    }
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: \.path)) {
            WithViewStore(store, observe: {$0}) { viewStore in
                TabView(selection: viewStore.binding(get: \.tab.selectedTab, send: { RootStore.Action.tab(.tabSelected($0))} )) {
                    makeRootView()
                }
                .navigationTitle(viewStore.tab.selectedTab.rawValue.capitalized)
                .toolbar {
                    makeToolbarItems(viewStore)
                }
            }
        } destination: {
            makeDestination($0)
        }
    }
}

#Preview {
    RootView(store: .init(initialState: RootStore.State(), reducer: {
        RootStore()
    }, withDependencies: {
        $0.apiClient = .testValue
    }))
}

extension RootView {
    
    @ViewBuilder
    private func makeRootView() -> some View {
        CharactersView(store: store.scope(state: \.tab.characters,
                                    action: \.tab.characters))
        .tag(TabStore.Tab.characters)
        .tabItem { Text("Characters") }
        
        EpisodesView(rootStore: store,
                     store: store.scope(state: \.tab.episodes, action: \.tab.episodes))
        .tag(TabStore.Tab.episodes)
        .tabItem { Text("Episodes") }
        
        LocationsView(store: store.scope(state: \.tab.locations,
                                         action: \.tab.locations))
        .tag(TabStore.Tab.locations)
        .tabItem { Text("Locations") }
    }
    
    
    private func makeDestination(_ type: RootStore.Path.State) -> some View {
        Group {
            switch type {
            case .details:
                CaseLet(
                    \RootStore.Path.State.details,
                     action: RootStore.Path.Action.details) {
                         PersonDetails(store:$0)
                     }
            case .search:
                CaseLet(
                    \RootStore.Path.State.search,
                     action: RootStore.Path.Action.search) {
                         SearchView(rootStore: store, store: $0)
                     }
            }
        }
    }
    
    private func makeToolbarItems(_ viewStore: ViewStore<RootStore.State, RootStore.Action>) -> some ToolbarContent {
        Group {
            let tabType = viewStore.tab.selectedTab
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    viewStore.send(.navigate(.search(.init(type: tabType.searchType))))
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
    }
}
