//
//  EpisodesStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct EpisodesStore {
    
    struct State: Equatable {
        var profile: String = ""
    }
    
    enum Action {
        case fetch
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetch:
                return .none
            }
        }
    }
}
