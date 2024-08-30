//
//  HomeUnitTests.swift
//  MoviesDBTests
//
//  Created by Martin Lago on 30/8/24.
//

import XCTest
import Combine

@testable import MoviesDB

@MainActor
final class HomeViewModelTests: XCTestCase {
    
    private var viewModel: HomeViewModel!
    private var mockRepository: MoviesRepositoryMock!
    
    private var cancellables = Set<AnyCancellable>()
    private var receivedStates = [HomeState]()
    
    @MainActor override func setUp() {
        super.setUp()
        mockRepository = MoviesRepositoryMock()
        viewModel = HomeViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        receivedStates = []
        cancellables = []
        super.tearDown()
    }

    // Test case to check if `initialization` updates state correctly
    func testInitializationSuccess() {
        let movies = MoviesRepositoryMock.getMoviesResponse()?.results ?? []
        let firstThreeMovies = Array(movies.prefix(upTo: 3))
        
        let expectation = expectation(description: "Home successful initialization expectation.")
        let expectedStates: [HomeState] = [
          .idle,
          .loadingAllMovies,
          .didLoadAllMovies(movies, firstThreeMovies)
        ]
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink { state in
                self.receivedStates.append(state)
                if self.receivedStates.count == expectedStates.count {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.initialization(quantity: 3)
        
        waitForExpectations(timeout: 1, handler: nil)

        XCTAssertEqual(expectedStates, receivedStates)
    }
    
    func testSwitchCategorySuccess() {
        let movies = MoviesRepositoryMock.getMoviesResponse()?.results ?? []
        
        let expectation = expectation(description: "Home category change expectation.")
        let expectedStates: [HomeState] = [
          .idle,
          .loadingMovies,
          .didLoadMovies(movies)
        ]
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink { state in
                self.receivedStates.append(state)
                if self.receivedStates.count == expectedStates.count {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.switchCategory(to: .topRated)
        
        waitForExpectations(timeout: 1, handler: nil)

        XCTAssertEqual(expectedStates, receivedStates)        
    }

}
