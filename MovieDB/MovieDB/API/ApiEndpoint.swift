//
//  ApiEndpoint.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

// MARK: - Api Endpoints

enum ApiEndpoint {
    case popular
    case nowPlaying
    case upcoming
    case topRated
    case search
    
    var method: String {
        switch self {
        case .popular, .nowPlaying, .upcoming, .topRated, .search:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .popular:
            "movie/popular"
        case .nowPlaying:
            "movie/now_playing"
        case .upcoming:
            "movie/upcoming"
        case .topRated:
            "movie/top_rated"
        case .search:
            "search/movie"
        }
    }
}
