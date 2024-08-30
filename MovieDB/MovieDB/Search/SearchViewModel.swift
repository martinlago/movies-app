//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI
import Combine

enum SearchState: Equatable {
    case idle
    case loadingGenres
    case didLoadGenres(Genres)
    case loadingSearch
    case didLoadSearch(Movies)
    case loadingDetail
    case didLoadMovieDetail(MovieDetail, MovieVideo?)
    case error
}

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published private(set) var state: SearchState = .idle
    
    private var repository: MoviesRepository
    
    private var cancellables: Set<AnyCancellable> = []
    let debouncedTextPublisher = PassthroughSubject<String, Never>()
        
    init(repository: MoviesRepository = MoviesRepositoryImp()) {
        self.repository = repository
        
        setupDebouncedText()
    }
    
}

// MARK: - Management

extension SearchViewModel {
    
    func initialization() {
        state = .loadingGenres
        
        Task {
            do {
                let genres = try await getGenres()
                state = .didLoadGenres(genres)
            } catch {
                state = .error
            }
        }
    }
    
    func setupDebouncedText() {
        debouncedTextPublisher
            .debounce(for: .seconds(0.8), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.searchMovies(query: text)
            }
            .store(in: &cancellables)
    }
    
    func searchMovies(query: String) {
        state = .loadingSearch
        
        Task {
            do {
                let movies = try await searchMovies(query: query)
                state = .didLoadSearch(movies)
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

private extension SearchViewModel {
    
    func getGenres() async throws -> Genres {
        return try await repository.getMoviesGenres()
    }
    
    func searchMovies(query: String) async throws -> Movies {
        return try await repository.searchMovies(by: query)
    }
    
    func getMovieDetail(for id: Int) async throws -> MovieDetail {
        return try await repository.getMovieDetail(for: id)
    }
    
    func getMovieVideos(for id: Int) async throws -> [MovieVideo] {
        return try await repository.getMovieVideos(for: id)
    }
    
}
