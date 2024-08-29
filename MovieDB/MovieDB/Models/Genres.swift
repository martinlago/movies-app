//
//  Genres.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

struct Genres: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable, Equatable, Hashable {
    let id: Int
    let name: String
}
