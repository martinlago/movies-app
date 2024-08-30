//
//  HomeUnitTestsErrors.swift
//  MovieDB
//
//  Created by Martin Lago on 30/8/24.
//

import XCTest
import Combine

@testable import MoviesDB

@MainActor
final class HomeViewModelTestsError: XCTestCase {
    
    private var viewModel: HomeViewModel!
    private var mockRepository: MoviesRepositoryMockError!
    
    private var cancellables = Set<AnyCancellable>()
    private var receivedStates = [HomeState]()
    
    @MainActor override func setUp() {
        super.setUp()
        mockRepository = MoviesRepositoryMockError()
        viewModel = HomeViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        receivedStates = []
        cancellables = []
        super.tearDown()
    }
    
    func testInitializationError() {
        let expectation = expectation(description: "Home error initialization expectation.")
        let expectedStates: [HomeState] = [
            .idle,
            .loadingAllMovies,
            .error
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
    
    func testSwitchCategoryError() {
        let expectation = expectation(description: "Home error in category switch expectation.")
        let expectedStates: [HomeState] = [
            .idle,
            .loadingMovies,
            .error
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
        
        viewModel.switchCategory(to: .upcoming)
        
        waitForExpectations(timeout: 1, handler: nil)
                
        XCTAssertEqual(expectedStates, receivedStates)
    }
}

