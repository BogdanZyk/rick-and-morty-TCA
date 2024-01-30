//
//  HomeStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import ComposableArchitecture

@Reducer
struct HomeStore {
    
    struct State: Equatable{
        var pesons = [String]()
    }
    
    enum Action {
      case fetchPersons
        case details(Int)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchPersons:
                return .none
            case .details:
                return .none
            }
        }
    }
}
