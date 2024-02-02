//
//  LocationsStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 02.02.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct LocationsStore {
    
    struct State: Equatable {
        var items: String = ""
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
