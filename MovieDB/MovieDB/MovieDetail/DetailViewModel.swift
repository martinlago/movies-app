//
//  DetailViewModel.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

enum DetailState: Equatable {
    case idle
    case loadingDetail
    case didLoadMovieDetail(_ movie: MovieDetail, _ video: MovieVideo?)
    case error
}

@MainActor
class DetailViewModel: ObservableObject {
    
    @Published private(set) var state: DetailState = .idle
    
    private var repository: MoviesRepository
    
    init(repository: MoviesRepository = MoviesRepositoryImp()) {
        self.repository = repository
    }
    
}

// MARK: - Management

extension DetailViewModel {
    
    func initialization(for movieId: Int) {
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

private extension DetailViewModel {
    
    func getMovieDetail(for id: Int) async throws -> MovieDetail {
        return try await repository.getMovieDetail(for: id)
    }
    
    func getMovieVideos(for id: Int) async throws -> [MovieVideo] {
        return try await repository.getMovieVideos(for: id)
    }
    
}
