//
//  PersonDetails.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 30.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct PersonDetails: View {
    let store: StoreOf<PersonDetailsStore>
    var body: some View {
        VStack {
            CharacterDetailsView(store: store.scope(state: \.details, action: \.details))
            Spacer()
        }
    }
}

#Preview {
    PersonDetails(store: .init(initialState: PersonDetailsStore.State(id: "1"), reducer: {
        PersonDetailsStore()
    }))
}
