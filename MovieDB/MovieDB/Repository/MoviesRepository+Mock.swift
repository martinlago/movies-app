//
//  MoviesRepository+Mock.swift
//  MovieDB
//
//  Created by Martin Lago on 30/8/24.
//

import Foundation

// MARK: - Movies Repository | Mock

class MoviesRepositoryMock: MoviesRepository {
    
    func getMoviesGenres() async throws -> Genres {
        []
    }
    
    func getPopularMovies() async throws -> Movies {
        guard let response = MoviesRepositoryMock.getMoviesResponse() else {
            throw MockError.mockError
        }
        return response.results
    }
    
    func getNowPlayingMovies(quantity: Int) async throws -> Movies {
        guard let response = MoviesRepositoryMock.getMoviesResponse() else {
            throw MockError.mockError
        }
        return Array(response.results.prefix(upTo: quantity))
    }
    
    func getUpcomingMovies(quantity: Int) async throws -> Movies {
        guard let response = MoviesRepositoryMock.getMoviesResponse() else {
            throw MockError.mockError
        }
        return Array(response.results.prefix(upTo: quantity))
    }
    
    func getTopRatedMovies(quantity: Int) async throws -> Movies {
        guard let response = MoviesRepositoryMock.getMoviesResponse() else {
            throw MockError.mockError
        }
        return Array(response.results.prefix(upTo: quantity))
    }
    
    func searchMovies(by query: String) async throws -> Movies {
        []
    }
    
    func getMovieDetail(for id: Int) async throws -> MovieDetail {
        MovieDetail(id: 1, title: "", overview: "", releaseDate: "", posterPath: nil, backdropPath: nil, voteAverage: 5, genres: [], runtime: 2)
    }
    
    func getMovieVideos(for id: Int) async throws -> [MovieVideo] {
        []
    }
    
}

extension MoviesRepositoryMock {
    
    static func getMoviesResponse() -> CommonResponse<Movie>? {
        let responseString = """
        {
            "page": 1,
            "results": [
                    {
                        "id": 1,
                        "title": "Inception",
                        "release_date": "2010-07-16",
                        "poster_path": "/poster/inception.jpg",
                        "vote_average": 8.8,
                        "genre_ids": [28, 12, 878]
                    },
                    {
                        "id": 2,
                        "title": "The Dark Knight",
                        "release_date": "2008-07-18",
                        "poster_path": "/poster/dark_knight.jpg",
                        "vote_average": 9.0,
                        "genre_ids": [28, 80, 18]
                    },
                    {
                        "id": 3,
                        "title": "Interstellar",
                        "release_date": "2014-11-07",
                        "poster_path": "/poster/interstellar.jpg",
                        "vote_average": 8.6,
                        "genre_ids": [12, 18, 878]
                    },
                    {
                        "id": 4,
                        "title": "The Matrix",
                        "release_date": "1999-03-31",
                        "poster_path": "/poster/matrix.jpg",
                        "vote_average": 8.7,
                        "genre_ids": [28, 878]
                    },
                    {
                        "id": 5,
                        "title": "Pulp Fiction",
                        "release_date": "1994-10-14",
                        "poster_path": "/poster/pulp_fiction.jpg",
                        "vote_average": 8.9,
                        "genre_ids": [80, 53, 18]
                    },
                    {
                        "id": 6,
                        "title": "Spiderman",
                        "release_date": "2013-10-16",
                        "poster_path": "/poster/spiderman.jpg",
                        "vote_average": 8.8,
                        "genre_ids": [28, 12, 878]
                    },
                ],
            "total_pages": 1234,
            "total_results": 55234
        }
        """
        let responseData = Data(responseString.utf8)

        return try? JSONDecoder().decode(CommonResponse<Movie>.self, from: responseData)
    }
}
