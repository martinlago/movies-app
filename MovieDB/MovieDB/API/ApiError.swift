//
//  ApiError.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

// MARK: - Api Errors

enum ApiError: Error {
    case invalidUrl
    case invalidResponse
    case errorOnRequest
    case error(String)
}
