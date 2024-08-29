//
//  ApiManager.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

// MARK: - Api Manager

class ApiManager {
    
    static let shared = ApiManager()
    
    private init() {}
    
    func performRequest<D: Decodable>(
        to url: String = ApiConstants.baseURL,
        for endpoint: ApiEndpoint,
        with params: [URLQueryItem] = []
    ) async throws -> D {
        let request = try createRequest(to: url, for: endpoint, with: params)
        
        do {
            let (responseData, _) = try await URLSession.shared.data(for: request)
            
            if let response = try? JSONDecoder().decode(D.self, from: responseData) {
                return response
            } else {
                throw ApiError.invalidResponse
            }
        } catch {
            throw ApiError.errorOnRequest
        }
    }

}

// MARK: - Helpers

private extension ApiManager {
    
    func createRequest(to urlString: String, for endpoint: ApiEndpoint, with queryItems: [URLQueryItem] = []) throws -> URLRequest {
        guard let url = URL(string: urlString),
              var components = URLComponents(url: url.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true)
        else {
            throw ApiError.invalidUrl
        }
        
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        // TODO: Remove this forced unwrap
        var request = URLRequest(url: components.url!)
        
        /// Method
        request.httpMethod = endpoint.method
        
        /// Headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDk1MTY5ZGM0NzViMjM1NjExYzEzMWEzN2RjOTUyOSIsIm5iZiI6MTcyNDg1Mzg5Ny4zMzEzMDksInN1YiI6IjY2Y2U3MjhkNDkzNzNhMjZjNmQzZDYxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uydC23wqL38pwgNKnBDMlej3KtZ8zIpGVHGNi0ecLAw", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
}
