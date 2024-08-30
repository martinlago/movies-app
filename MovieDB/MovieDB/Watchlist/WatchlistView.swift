//
//  WatchlistView.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI
import SwiftData

struct WatchlistView: View {
    
    @EnvironmentObject var router: Router<WatchlistRoute>
    
    @Query(sort: [SortDescriptor(\DBMovie.dateAdded, order: .reverse)]) var movies: [DBMovie]
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Text("Watchlist")
                    .titleStyle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                
                if movies.isEmpty {
                    PlaceholderView(
                        image: "EmptyWatchlist",
                        label: "There are no movies yet!",
                        description: "Find your favorite movies and add them to the Watchlist"
                    )
                    .frame(maxHeight: .infinity)
                    
                } else {
                    ScrollView {
                        ForEach(movies) { movie in
                            MovieListItem(
                                title: movie.title,
                                punctuation: movie.voteAverage,
                                genre: movie.genre,
                                releaseYear: movie.releaseDate.yearFromDate ?? "-",
                                duration: movie.runtime,
                                image: GenericImage(data: movie.posterImage, width: 100, height: 140)
                            ) {
                                onMovieTap(movie)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .padding(.horizontal, 24)
            .background(Color.background.ignoresSafeArea())
            .navigationDestination(for: WatchlistRoute.self) { route in
                switch route {
                case .detail(let detail, let posterData, let backdropData):
                    DetailView(router: router, detail: detail, video: nil, posterData: posterData, backdropData: backdropData)
                }
            }
        }
    }
}

// MARK: - Helpers

private extension WatchlistView {
    
    func onMovieTap(_ dbMovie: DBMovie) {
        let movie = MovieDetail(
            id: dbMovie.id,
            title: dbMovie.title,
            overview: dbMovie.overview,
            releaseDate: dbMovie.releaseDate,
            posterPath: nil,
            backdropPath: nil,
            voteAverage: dbMovie.voteAverage,
            genres: [
                Genre(id: 0, name: dbMovie.genre)
            ],
            runtime: dbMovie.runtime
        )
        
        router.push(.detail(movie, dbMovie.posterImage, dbMovie.backdropImage))
    }
    
}

#Preview {
    WatchlistView()
}
