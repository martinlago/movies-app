//
//  MovieVideo.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

struct MovieVideoResponse: Decodable {
    let id: Int
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Equatable, Hashable {
    let id: String
    let key: String
    let site: String
    let type: String
}
