//
//  DBMovieManager.swift
//  MovieDB
//
//  Created by Martin Lago on 30/8/24.
//

import SwiftData
import SwiftUI

final class DBMovieManager {
    private let modelContext: ModelContext
    private(set) var movies = [DBMovie]()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
    }
    
    func addMovie(_ movie: DBMovie) {
        modelContext.insert(movie)
        try? modelContext.save()
        fetchData()
    }
    
    func clear() {
        try? modelContext.delete(model: DBMovie.self)
        try? modelContext.save()
        fetchData()
    }
    
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<DBMovie>(sortBy: [SortDescriptor(\.voteAverage, order: .reverse)])
            movies = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
}
