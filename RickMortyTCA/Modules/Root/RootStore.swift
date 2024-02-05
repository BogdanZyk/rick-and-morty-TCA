//
//  RootStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RootStore {
    
    struct State: Equatable {
        var tab = TabStore.State()
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case navigate(Path.State)
        case path(StackAction<Path.State, Path.Action>)
        case popToRoot
        case tab(TabStore.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .path:
                return .none
            case let .navigate(path):
                state.path.append(path)
                return .none
            case .popToRoot:
                state.path.removeAll()
                return .none
            case let .tab(.home(.charactersStore(.onTapCell(id)))):
                return .run { send in
                    await send(.navigate(.details(.init(id: id))))
                }
            case .tab:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
        Scope(state: \.tab, action: \.tab) {
            TabStore()
        }
    }
}



extension RootStore {
    
    @Reducer
    struct Path {
        enum State: Equatable, Hashable {
            case details(PersonDetailsStore.State)
            case search(SearchStore.State)
        }
        
        enum Action {
            case details(PersonDetailsStore.Action)
            case search(SearchStore.Action)
        }
        
        var body: some Reducer<State, Action> {
            Scope(state: \.details, action: \.details) {
                PersonDetailsStore()
            }
            Scope(state: \.search, action: \.search) {
                SearchStore()
            }
        }
    }
}


@Reducer
struct TabStore {
    
    struct State: Equatable {
        var selectedTab: Tab = .characters
        var home = HomeStore.State()
        var episodes = EpisodesStore.State()
    }
    
    enum Action {
        case tabSelected(Tab)
        case home(HomeStore.Action)
        case episodes(EpisodesStore.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none
            case .home:
                return .none
            case .episodes:
                return .none
            }
        }
        Scope(state: \.home, action: \.home) {
            HomeStore()
        }
        Scope(state: \.episodes, action: \.episodes) {
            EpisodesStore()
        }
    }
}

extension TabStore {
    
    enum Tab: String, CaseIterable {
        case characters, episodes, locations
    }
    
}
