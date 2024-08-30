//
//  MoviesRepository+MockError.swift
//  MovieDB
//
//  Created by Martin Lago on 30/8/24.
//

import Foundation

enum MockError: Error {
    case mockError
}

class MoviesRepositoryMockError: MoviesRepository {
    
    func getMoviesGenres() async throws -> Genres {
        throw MockError.mockError
    }
    
    func getPopularMovies() async throws -> Movies {
        throw MockError.mockError

    }
    
    func getNowPlayingMovies(quantity: Int) async throws -> Movies {
        throw MockError.mockError

    }
    
    func getUpcomingMovies(quantity: Int) async throws -> Movies {
        throw MockError.mockError

    }
    
    func getTopRatedMovies(quantity: Int) async throws -> Movies {
        throw MockError.mockError

    }
    
    func searchMovies(by query: String) async throws -> Movies {
        throw MockError.mockError
    }
    
    func getMovieDetail(for id: Int) async throws -> MovieDetail {
        throw MockError.mockError
    }
    
    func getMovieVideos(for id: Int) async throws -> [MovieVideo] {
        throw MockError.mockError
    }
    
}
