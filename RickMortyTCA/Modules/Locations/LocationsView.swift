//
//  LocationsView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 02.02.2024.
//

import SwiftUI
import ComposableArchitecture

struct LocationsView: View {
    let store: StoreOf<LocationsStore>
    var body: some View {
        Text("LocationsView")
    }
}

#Preview {
    LocationsView(store: .init(initialState: LocationsStore.State(), reducer: {
        LocationsStore()
    }))
}
