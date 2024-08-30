//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

enum HomeState: Equatable {
    case idle
    case loadingAllMovies
    case didLoadAllMovies(Movies, Movies)
    case loadingMovies
    case didLoadMovies(Movies)
    case loadingDetail
    case didLoadMovieDetail(MovieDetail, MovieVideo?)
    case error
}

enum MoviesType: Equatable {
    case nowPlaying
    case upcoming
    case topRated
}

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published private(set) var state: HomeState = .idle
    
    private var repository: MoviesRepository
    
    init(repository: MoviesRepository = MoviesRepositoryImp()) {
        self.repository = repository
    }
    
}

// MARK: - Management

extension HomeViewModel {
    
    func initialization(quantity: Int) {
        state = .loadingAllMovies
        
        Task {
            do {
                async let popularMoviesResponse = getPopularMovies()
                async let nowPlayingMoviesResponse = getMovies(of: .nowPlaying, and: quantity)
                let data = try await (popularMoviesResponse, nowPlayingMoviesResponse)
                
                state = .didLoadAllMovies(data.0, data.1)
            } catch {
                state = .error
            }
        }
    }
    
    func switchCategory(to type: MoviesType) {
        state = .loadingMovies
        
        Task {
            do {
                let movies = try await getMovies(of: type, and: 6)
                
                state = .didLoadMovies(movies)
            } catch {
                state = .error
            }
        }
    }
    
    func getMovieDetail(for movieId: Int) {
        state = .loadingDetail
        
        Task {
            do {
                async let movieDetailResponse = getMovieDetail(for: movieId)
                async let movieVideosResponse = getMovieVideos(for: movieId)
                let data = try await (movieDetailResponse, movieVideosResponse)
                
                let video = data.1.first { video in
                    video.type == "Trailer"
                }
                
                state = .didLoadMovieDetail(data.0, video)
            } catch {
                state = .error
            }
        }
    }
}

// MARK: - API Calls

private extension HomeViewModel {
    
    func getPopularMovies() async throws -> Movies {
        return try await repository.getPopularMovies()
    }
    
    func getMovies(of type: MoviesType, and quantity: Int) async throws -> Movies {
        switch type {
        case .nowPlaying:
            return try await repository.getNowPlayingMovies(quantity: quantity)
        case .upcoming:
            return try await repository.getUpcomingMovies(quantity: quantity)
        case .topRated:
            return try await repository.getTopRatedMovies(quantity: quantity)
        }
    }
    
    func getMovieDetail(for id: Int) async throws -> MovieDetail {
        return try await repository.getMovieDetail(for: id)
    }
    
    func getMovieVideos(for id: Int) async throws -> [MovieVideo] {
        return try await repository.getMovieVideos(for: id)
    }
    
}
