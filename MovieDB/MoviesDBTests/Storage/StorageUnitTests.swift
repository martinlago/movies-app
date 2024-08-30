//
//  StorageUnitTests.swift
//  MovieDB
//
//  Created by Martin Lago on 30/8/24.
//

import XCTest
import SwiftData

@testable import MoviesDB

@MainActor
class DBMovieTests: XCTestCase {
    
    private var manager: DBMovieManager!
    
    let testContainer: ModelContainer = {
        do {
            return try ModelContainer (
                for: DBMovie.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
        } catch {
            fatalError("Failed to create container")
        }
    }()
    
    @MainActor override func setUp() {
        super.setUp()
        manager = DBMovieManager(modelContext: testContainer.mainContext)
    }
    
    override func tearDown() {
        manager = nil
        super.tearDown()
    }
    
    func testAppStartsEmpty() {
        XCTAssertEqual(manager.movies.count, 0)
    }
    
    func testAddMovie() {
        let movie = DBMovie(
            id: 1,
            title: "Test Movie",
            releaseDate: "2024-01-01",
            voteAverage: 8.5,
            runtime: 120,
            genre: "Action",
            overview: "This is a test movie."
        )
        manager.addMovie(movie)
        
        XCTAssertEqual(manager.movies.count, 1)
        XCTAssertEqual(manager.movies.first?.title, "Test Movie")
    }
    
    func testAddMultipleMovies() {
        let movie = DBMovie(
            id: 1,
            title: "First Movie",
            releaseDate: "2024-01-01",
            voteAverage: 6,
            runtime: 120,
            genre: "Action",
            overview: "This is a test movie."
        )
        let movie2 = DBMovie(
            id: 2,
            title: "Second Movie",
            releaseDate: "2024-01-01",
            voteAverage: 9.1,
            runtime: 120,
            genre: "Action",
            overview: "This is a test movie."
        )
        let movie3 = DBMovie(
            id: 3,
            title: "Third Movie",
            releaseDate: "2024-01-01",
            voteAverage: 4.1,
            runtime: 120,
            genre: "Action",
            overview: "This is a test movie."
        )
        manager.addMovie(movie)
        manager.addMovie(movie2)
        manager.addMovie(movie3)
        
        XCTAssertEqual(manager.movies.count, 3)
        XCTAssertEqual(manager.movies.first?.title, "Second Movie") // The one with the best voteAverage
    }
    
    func testRemoveMovie() {
        let movie = DBMovie(
            id: 1,
            title: "First Movie",
            releaseDate: "2024-01-01",
            voteAverage: 6,
            runtime: 120,
            genre: "Action",
            overview: "This is a test movie."
        )
        manager.addMovie(movie)
        
        XCTAssertEqual(manager.movies.count, 1)

        manager.clear()
        XCTAssertEqual(manager.movies.count, 0)
    }
    
}
