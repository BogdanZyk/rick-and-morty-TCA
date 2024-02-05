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
        HomeView(store: store.scope(state: \.tab.home, action: \.tab.home))
            .tag(TabStore.Tab.characters)
            .tabItem { Text("Characters") }
            
            
        EpisodesView(store: store.scope(state: \.tab.episodes, action: \.tab.episodes))
            .tag(TabStore.Tab.episodes)
            .tabItem { Text("Episodes") }
    }
    
    
    private func makeDestination(_ type: RootStore.Path.State) -> some View {
        Group {
            switch type {
            case .details:
                CaseLet(
                    \RootStore.Path.State.details,
                     action: RootStore.Path.Action.details) {
                         PersonDetails.init(store:$0)
                     }
            case .search:
                CaseLet(
                    \RootStore.Path.State.search,
                     action: RootStore.Path.Action.search) {
                         SearchView.init(store: $0)
                     }
            }
        }
    }
    
    private func makeToolbarItems(_ viewStore: ViewStore<RootStore.State, RootStore.Action>) -> some ToolbarContent {
        Group {
            if viewStore.tab.selectedTab == .characters {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        viewStore.send(.navigate(.search(.init())))
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }
    }
}
