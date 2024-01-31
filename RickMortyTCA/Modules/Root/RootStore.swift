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
        var path = StackState<Path.State>()
        var selectedTab: Tab = .home
    }
    
    enum Action {
        case tabSelected(Tab)
        case navigate(Path.State)
        case path(StackAction<Path.State, Path.Action>)
        case popToRoot
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
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
}


extension RootStore {
    
    enum Tab: String, CaseIterable {
        case home, search, profile
    }
    
}


extension RootStore {
    
    @Reducer
    struct Path {
        enum State: Equatable, Hashable {
            case details(DetailsStore.State)
        }
        
        enum Action {
            case details(DetailsStore.Action)
        }
        
        var body: some Reducer<State, Action> {
            Scope(state: \.details, action: \.details) {
                DetailsStore()
            }
        }
    }
}

