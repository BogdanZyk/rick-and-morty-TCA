//
//  HomeStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import ComposableArchitecture
import GraphqlAPI

@Reducer
struct HomeStore {
    
    struct State: Equatable {
        var charactersStore = CharactersStore.State()
    }
    
    enum Action {
        case charactersStore(CharactersStore.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.charactersStore, action: \.charactersStore) {
            CharactersStore()
        }
        //._printChanges()
    }
}
