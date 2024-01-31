//
//  CharactersStoreTests.swift
//  RickMortyTCATests
//
//  Created by Bogdan Zykov on 31.01.2024.
//

import XCTest
import ComposableArchitecture
import GraphqlAPI
@testable import RickMortyTCA

@MainActor
final class CharactersStoreTests: XCTestCase {

    func test_onAppear() async {
        
        let store = TestStore(initialState: CharactersStore.State()) {
            CharactersStore()
        } withDependencies: {
            $0.apiClient = .testValue
        }
        
        await store.send(.onAppear)
        
        await store.receive(\.fetch)
        
        await store.receive(\.handleResult) {
            $0.characters = .init(arrayLiteral: .init(character: PaginatedCharacter.mock))
            $0.next = 1
            $0.total = 2
        }
        
        await store.send(.onAppear)
        XCTAssertEqual(store.state.characters.count, 1)
    }
    
    
    func test_fetchNextPage() async {
        
        let store = TestStore(initialState: CharactersStore.State(characters: .init(arrayLiteral: .init(character: PaginatedCharacter.mock)), total: 2, next: 1)) {
            CharactersStore()
        } withDependencies: {
            $0.apiClient = .testValue
        }
        
        await store.send(.characters(.element(id: "1", action: .onAppear)))
        
        await store.receive(\.fetchNextPage)
        
        await store.receive(\.fetch)
        
        await store.receive(\.handleResult) {
            $0.characters.append(CharacterStore.State(character: .mock2))
            $0.next = 2
            $0.total = 2
        }
    }

    func test_refetch() async {
        let store = TestStore(initialState: CharactersStore.State(characters: [], total: 2, next: 2)) {
            CharactersStore()
        } withDependencies: {
            $0.apiClient = .testValue
        }
        
        await store.send(.refetch) {
            $0.next = 0
            $0.characters = []
        }
        
        await store.receive(\.fetch)
        
        await store.receive(\.handleResult) {
            $0.characters = .init(arrayLiteral: .init(character: PaginatedCharacter.mock))
            $0.next = 1
            $0.total = 2
        }
    }
}
