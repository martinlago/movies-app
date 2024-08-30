//
//  ApiEndpoint.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

// MARK: - Api Endpoints

enum ApiEndpoint {
    case genres
    case popular
    case nowPlaying
    case upcoming
    case topRated
    case search
    case movieDetail(id: Int)
    case movieVideos(id: Int)
    
    var method: String {
        switch self {
        case .genres, .popular, .nowPlaying, .upcoming, .topRated, .search, .movieDetail, .movieVideos:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .genres:
            "genre/movie/list"
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
        case .movieDetail(let id):
            "movie/\(id)"
        case .movieVideos(let id):
            "movie/\(id)/videos"
        }
    }
}
