//
//  DBMovie.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI
import SwiftData

@Model
class DBMovie {
    var id: Int
    var dateAdded: Date
    var title: String
    var releaseDate: String
    var voteAverage: Float
    var runtime: Int
    var genre: String
    var overview: String
    @Attribute(.externalStorage) var posterImage: Data?
    @Attribute(.externalStorage) var backdropImage: Data?
    
    init(
        id: Int,
        title: String,
        releaseDate: String,
        voteAverage: Float,
        runtime: Int,
        genre: String,
        overview: String,
        posterImage: Data? = nil,
        backdropImage: Data? = nil
    ) {
        self.id = id
        self.dateAdded = .now
        self.title = title
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.runtime = runtime
        self.genre = genre
        self.overview = overview
        self.posterImage = posterImage
        self.backdropImage = backdropImage
    }
}
