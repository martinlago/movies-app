//
//  MoviesRepository.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

// MARK: - Movies Repository Protocol

protocol MoviesRepository {
    func getMoviesGenres() async throws -> Genres
    func getPopularMovies() async throws -> [Movie]
    func getNowPlayingMovies(quantity: Int) async throws -> [Movie]
    func getUpcomingMovies(quantity: Int) async throws -> [Movie]
    func getTopRatedMovies(quantity: Int) async throws -> [Movie]
    func searchMovies(by query: String) async throws -> [Movie]
    func getMovieDetail(for id: Int) async throws -> MovieDetail
    func getMovieVideos(for id: Int) async throws -> [MovieVideo]
}
