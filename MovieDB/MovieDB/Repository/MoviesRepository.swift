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
    func getPopularMovies() async throws -> Movies
    func getNowPlayingMovies(quantity: Int) async throws -> Movies
    func getUpcomingMovies(quantity: Int) async throws -> Movies
    func getTopRatedMovies(quantity: Int) async throws -> Movies
    func searchMovies(by query: String) async throws -> Movies
    func getMovieDetail(for id: Int) async throws -> MovieDetail
    func getMovieVideos(for id: Int) async throws -> [MovieVideo]
}
