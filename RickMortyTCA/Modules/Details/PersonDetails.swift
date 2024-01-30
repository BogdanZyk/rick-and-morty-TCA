//
//  PersonDetails.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct PersonDetails: View {
    let store: StoreOf<DetailsStore>
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            Text(viewStore.id.formatted())
        }
    }
}

#Preview {
    PersonDetails(store: .init(initialState: DetailsStore.State(id: 1), reducer: {
        DetailsStore()
    }))
}
