//
//  LocationsStoreTests.swift
//  RickMortyTCATests
//
//  Created by Bogdan Zykov on 05.02.2024.
//

import XCTest
import ComposableArchitecture
import GraphqlAPI
@testable import RickMortyTCA

@MainActor
final class LocationsStoreTests: XCTestCase {

    func test_onAppear() async {
        
        let store = TestStore(initialState: LocationsStore.State()) {
            LocationsStore()
        } withDependencies: {
            $0.apiClient = .testValue
        }
        
        await store.send(.onAppear)
        
        await store.receive(\.fetch)
        
        await store.receive(\.handleResult) {
            $0.locations = [PaginatedLocation.mock2]
            $0.next = 1
            $0.total = 2
        }
        
        await store.send(.onAppear)
        XCTAssertEqual(store.state.locations.count, 1)
    }
    
    
    func test_fetchNextPage() async {
        
        let store = TestStore(initialState: LocationsStore.State(locations: [PaginatedLocation.mock], total: 2, next: 1)) {
            LocationsStore()
        } withDependencies: {
            $0.apiClient = .testValue
        }
        
        await store.send(.fetchNextPage("1"))
        
        await store.receive(\.fetch)
        
        await store.receive(\.handleResult) {
            $0.locations.append(PaginatedLocation.mock)
            $0.next = 2
            $0.total = 2
        }
    }

    func test_refetch() async {
        let store = TestStore(initialState: LocationsStore.State(locations: [], total: 2, next: 2)) {
            LocationsStore()
        } withDependencies: {
            $0.apiClient = .testValue
        }
        
        await store.send(.refetch) {
            $0.next = 0
            $0.locations = []
        }
        
        await store.receive(\.fetch)
        
        await store.receive(\.handleResult) {
            $0.locations = [PaginatedLocation.mock2]
            $0.next = 1
            $0.total = 2
        }
    }

}
