//
//  PersonDetailsStore.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 01.02.2024.
//

import ComposableArchitecture

@Reducer
struct PersonDetailsStore {
    
    struct State: Equatable, Hashable {
        var details: CharacterDetailsStore.State
        var episodes: EpisodesListStore.State
        
        init(id: String) {
            self.details = .init(id: id)
            self.episodes = .init(id: id)
        }
    }
    
    enum Action {
        case details(CharacterDetailsStore.Action)
        case episodes(EpisodesListStore.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.details, action: \.details) {
            CharacterDetailsStore()
        }
        Scope(state: \.episodes, action: \.episodes) {
            EpisodesListStore()
        }
    }
}
