//
//  SearchView.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var router: Router<SearchRoute>
    @StateObject private var viewModel = SearchViewModel()
    
    /// State variables
    @State private var text = ""
    @State var genres: Genres = []
    @State var movies: Movies = []
    @State private var isTyping = false
    @State private var isLoading = false
    @State private var showError = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Text("Search")
                    .titleStyle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                
                if showError {
                    ErrorView()
                } else {
                    searchComponent
                    searchContent
                }
            }
            .padding(.horizontal, 24)
            .background(Color.background.ignoresSafeArea())
            .navigationDestination(for: SearchRoute.self) { route in
                switch route {
                case .detail(let detail, let video):
                    DetailView(router: router, detail: detail, video: video)
                }
            }
        }
        .background(Color.background.ignoresSafeArea())
        .onAppear {
            viewModel.initialization()
        }
        .onReceive(viewModel.$state, perform: evaluateState)
    }
}

// MARK: - View helpers

extension SearchView {
    
    var searchComponent: some View {
        CustomTextField(text: $text)
            .onChange(of: text) {
                isTyping = true
                viewModel.debouncedTextPublisher.send(text)
            }
    }
    
    var searchContent: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    if isLoading || isTyping {
                        ProgressView()
                        
                    } else if movies.isEmpty {
                        placeholder
                        
                    } else {
                        ForEach(movies) { movie in
                            MovieListItem(
                                title: movie.title,
                                punctuation: movie.voteAverage,
                                genre: getGenreName(for: movie.genres.first),
                                releaseYear: movie.releaseDate.yearFromDate ?? "-",
                                image: GenericImage(url: movie.posterPath, width: 100, height: 140)
                            ) {
                                viewModel.getMovieDetail(for: movie.id)
                            }
                            .padding(.vertical, 16)
                        }
                    }
                }
                .frame(minWidth: geometry.size.width, minHeight: geometry.size.height)
            }
            .scrollDismissesKeyboard(.immediately)
            .scrollIndicators(.hidden)
        }
    }
    
    var placeholder: some View {
        PlaceholderView(
            image: text.isEmpty ? "EmptyWatchlist" : "EmptySearch",
            label: text.isEmpty ? "Search movies" : "No results for your search",
            description: text.isEmpty ?  "Find your favorite movies searching by their names" : "Try with another name in order to get results"
        )
    }
    
}

// MARK: - Helpers

private extension SearchView {
    
    func getGenreName(for genreId: Int?) -> String {
        return genres.first { $0.id == genreId }?.name ?? "-"
    }
    
    func evaluateState(_ state: SearchState) {
        switch state {
        case .idle:
            break
        case .loadingGenres:
            isLoading = true
            showError = false
            
        case .didLoadGenres(let genres):
            isLoading = false
            self.genres = genres
            
        case .loadingSearch:
            isTyping = false
            isLoading = true
            
        case .didLoadSearch(let movies):
            self.movies = movies
            isLoading = false
            
        case .loadingDetail:
            break
            
        case .didLoadMovieDetail(let detail, let video):
            router.push(.detail(detail, video))
            
        case .error:
            showError = true
            isLoading = false
        }
    }
    
}

#Preview {
    SearchView()
}
