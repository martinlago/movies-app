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
        modelContext.insert(movie)
        isMovieAdded.toggle()
    }
    
    func deleteMovie() {
        if let movieToDelete = movies.first(where: { $0.id == detail.id }) {
            modelContext.delete(movieToDelete)
            isMovieAdded.toggle()
        }
    }
    
}
