//
//  HomeView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import GraphqlAPI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<HomeStore>

    var body: some View {
        VStack(spacing: 0) {
            CharacterList(store: store.scope(state: \.charactersStore, action: \.charactersStore))
        }
    }
}

#Preview {
    HomeView(store: .init(initialState: HomeStore.State(), reducer: {
        HomeStore()
    }, withDependencies: {
        $0.apiClient = .testValue
    }))
}


//extension HomeView {
//    
//    private var searchBar: some View {
//        HStack {
//            Text("Search")
//            Im
//        }
//    }
//    
//}
