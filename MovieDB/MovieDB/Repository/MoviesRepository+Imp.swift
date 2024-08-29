//
//  MoviesRepository+Imp.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

// MARK: - Movies Repository | Implementation

class MoviesRepositoryImp: MoviesRepository {
    
    func getMoviesGenres() async throws -> Genres {
        return try await ApiManager.shared.performRequest(for: .genres)
    }
    
    func getPopularMovies() async throws -> Movies {
        let response: CommonResponse<Movie> = try await ApiManager.shared.performRequest(for: .popular)
        return response.results
    }
    
    func getNowPlayingMovies(quantity: Int) async throws -> Movies {
        let response: CommonResponse<Movie> = try await ApiManager.shared.performRequest(for: .nowPlaying)
        return Array(response.results.prefix(upTo: quantity))
    }
    
    func getUpcomingMovies(quantity: Int) async throws -> Movies {
        let response: CommonResponse<Movie> = try await ApiManager.shared.performRequest(for: .upcoming)
        return Array(response.results.prefix(upTo: quantity))
    }
    
    func getTopRatedMovies(quantity: Int) async throws -> Movies {
        let response: CommonResponse<Movie> = try await ApiManager.shared.performRequest(for: .topRated)
        return Array(response.results.prefix(upTo: quantity))
    }
    
    func searchMovies(by query: String) async throws -> Movies {
        let queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        let response: CommonResponse<Movie> = try await ApiManager.shared.performRequest(for: .search, with: queryItems)
        
        return response.results
    }
    
    func getMovieDetail(for id: Int) async throws -> MovieDetail {
        return try await ApiManager.shared.performRequest(for: .movieDetail(id: id))
    }
    
    func getMovieVideos(for id: Int) async throws -> [MovieVideo] {
        let response: MovieVideoResponse = try await ApiManager.shared.performRequest(for: .movieVideos(id: id))
        return response.results
    }
    
}
