//
//  CommonResponse.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

struct CommonResponse<D: Decodable>: Decodable {
    let page: Int
    let results: [D]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
