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
        var persons = [String]()
    }
    
    enum Action {
        case fetchPersons
        case onAppear
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if !state.persons.isEmpty { return .none }
                return .run { send in
                    await send(.fetchPersons)
                }
            case .fetchPersons:
                print("fetchPersons")
                state.persons.append("1")
                return .none
            }
        }
    }
}
