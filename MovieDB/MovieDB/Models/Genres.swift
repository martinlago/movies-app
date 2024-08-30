//
//  Genres.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

typealias Genres = [Genre]

// MARK: - Genres models

struct GenresResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable, Equatable, Hashable {
    let id: Int
    let name: String
}
