//
//  EpisodesView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct EpisodesView: View {
    let store: StoreOf<EpisodesStore>
    var body: some View {
        Text("EpisodesView")
    }
}

#Preview {
    EpisodesView(store: .init(initialState: EpisodesStore.State(), reducer: {
        EpisodesStore()
    }))
}
