//
//  CharacterDetailsView.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 01.02.2024.
//

import SwiftUI
import ComposableArchitecture

struct CharacterDetailsView: View {
    let store: StoreOf<CharacterDetailsStore>
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            if let details = viewStore.personDetails {
                VStack(spacing: 0) {
                    GeometryReader{ proxy in
                        NukeImage(strUrl: details.image, resizeSize: .init(width: proxy.size.width, height: proxy.size.height), contentMode: .aspectFill, crop: true)
                    }
                    .frame(height: getRect().height / 2)
                    
                    VStack(spacing: 16) {
                        
                        LabeledContent {
                            Text(details.type ?? "")
                        } label: {
                            Text("Type:")
                        }

                        LabeledContent {
                            Text(details.gender ?? "")
                        } label: {
                            Text("Gender:")
                        }
                        
                        LabeledContent {
                            Text(details.status ?? "")
                        } label: {
                            Text("Status:")
                        }
                        
                        LabeledContent {
                            Text(details.species ?? "")
                        } label: {
                            Text("Species:")
                        }
                        
                    }
                    .padding()
                    Spacer()
                }
                .navigationTitle(details.name ?? "")
            } else {
                ProgressView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            store.send(.fetch)
        }
    }
}

#Preview {
    NavigationStack {
        CharacterDetailsView(store: .init(initialState: CharacterDetailsStore.State.init(id: "1"), reducer: {
            CharacterDetailsStore()
        }, withDependencies: {
            $0.apiClient = .testValue
        }))
    }

}
