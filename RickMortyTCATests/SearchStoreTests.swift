//
//  SearchStoreTests.swift
//  RickMortyTCATests
//
//  Created by Bogdan Zykov on 05.02.2024.
//

import XCTest
import ComposableArchitecture
import GraphqlAPI
@testable import RickMortyTCA

@MainActor
final class SearchStoreTests: XCTestCase {
    
    func test_searchAndClearQuery() async {
        let store = TestStore(initialState: SearchStore.State()) {
            SearchStore()
        } withDependencies: {
            $0.apiClient = .testValue
        }
        
        await store.send(.searchQueryChanged("s")) {
            $0.searchQuery = "s"
        }
        
        await store.send(.searchQueryChangeDebounced) {
            $0.loader = true
        }
        
        await store.receive(\.searchResponse.success) {
            $0.results = [PaginatedCharacter.mock, .mock2].map({$0.searchItem})
            $0.loader = false
        }
        
        await store.send(.searchQueryChanged("")) {
            $0.results = []
            $0.searchQuery = ""
        }
    }
    
    func test_searchFailure() async {
        let store = TestStore(initialState: SearchStore.State()) {
            SearchStore()
        } withDependencies: {
            $0.apiClient.searchCharacters = { @Sendable _ in throw SomethingWentWrong() }
        }
        
        await store.send(.searchQueryChanged("S")) {
            $0.searchQuery = "S"
        }
        await store.send(.searchQueryChangeDebounced) {
            $0.loader = true
        }
        await store.receive(\.searchResponse.failure) {
            $0.loader = false
        }
    }
    
    func test_clearQueryCancelsInFlightSearchRequest() async {
      let store = TestStore(initialState: SearchStore.State()) {
          SearchStore()
      } withDependencies: {
          $0.apiClient = .testValue
      }

      let searchQueryChanged = await store.send(.searchQueryChanged("S")) {
        $0.searchQuery = "S"
      }
      await searchQueryChanged.cancel()
      await store.send(.searchQueryChanged("")) {
        $0.searchQuery = ""
      }
    }
    
    private struct SomethingWentWrong: Equatable, Error {}
}

