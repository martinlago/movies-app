//
//  Movie.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

typealias Movies = [Movie]

// MARK: - Movie Models

struct Movie: Decodable, Equatable, Identifiable, Hashable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String?
    let voteAverage: Float
    let genres: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case genres = "genre_ids"
    }
}

struct MovieDetail: Decodable, Equatable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Float
    let genres: [Genre]
    let runtime: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, runtime
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
}
