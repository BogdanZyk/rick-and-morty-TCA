//
//  EpisodesStoreTests.swift
//  RickMortyTCATests
//
//  Created by Bogdan Zykov on 05.02.2024.
//

import XCTest
import ComposableArchitecture
import GraphqlAPI
@testable import RickMortyTCA

@MainActor
final class EpisodesStoreTests: XCTestCase {

    func test_onAppear() async {
        
        let store = TestStore(initialState: EpisodesStore.State()) {
            EpisodesStore()
        } withDependencies: {
            $0.apiClient = .testValue
        }
        
        await store.send(.onAppear)
        
        await store.receive(\.fetch)
        
        await store.receive(\.handleResult) {
            $0.episodes = [PaginatedEpisodes.mock2]
            $0.next = 1
            $0.total = 2
        }
        
        await store.send(.onAppear)
        XCTAssertEqual(store.state.episodes.count, 1)
    }
    
    
    func test_fetchNextPage() async {
        
        let store = TestStore(initialState: EpisodesStore.State(episodes: [PaginatedEpisodes.mock], total: 2, next: 1)) {
            EpisodesStore()
        } withDependencies: {
            $0.apiClient = .testValue
        }
        
        await store.send(.fetchNextPage("1"))
        
        await store.receive(\.fetch)
        
        await store.receive(\.handleResult) {
            $0.episodes.append(PaginatedEpisodes.mock)
            $0.next = 2
            $0.total = 2
        }
    }

    func test_refetch() async {
        let store = TestStore(initialState: EpisodesStore.State(episodes: [], total: 2, next: 2)) {
            EpisodesStore()
        } withDependencies: {
            $0.apiClient = .testValue
        }
        
        await store.send(.refetch) {
            $0.next = 0
            $0.episodes = []
        }
        
        await store.receive(\.fetch)
        
        await store.receive(\.handleResult) {
            $0.episodes = [PaginatedEpisodes.mock2]
            $0.next = 1
            $0.total = 2
        }
    }

}
