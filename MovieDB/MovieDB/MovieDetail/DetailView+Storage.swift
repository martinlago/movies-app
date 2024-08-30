//
//  DetailView+Storage.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import Foundation
import SwiftData

// MARK: - SwiftData helpers

extension DetailView {
    
    func fetchImage(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }
    
    func saveMovie() {
        let movie = DBMovie(
            id: detail.id,
            title: detail.title,
            releaseDate: detail.releaseDate,
            voteAverage: detail.voteAverage,
            runtime: detail.runtime,
            genre: detail.genres.first?.name ?? "-",
            overview: detail.overview
        )
        if let path = detail.posterPath, let url = URL(string: "\(ApiConstants.baseImagesURL)\(path)") {
            fetchImage(from: url) { data in
                movie.posterImage = data
            }
        }
        if let path = detail.backdropPath, let url = URL(string: "\(ApiConstants.baseImagesURL)\(path)") {
            fetchImage(from: url) { data in
                movie.backdropImage = data
            }
        }
        
        modelContext.insert(movie)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            tabBar.selectedTab = .saved
            router.popToRoot()
        }
    }
    
    func deleteMovie() {
        if let movieToDelete = movies.first(where: { $0.id == detail.id }) {
            modelContext.delete(movieToDelete)
            isMovieAdded.toggle()
            router.pop()
        }
    }
    
}
