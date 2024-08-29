//
//  HomeView.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var tabBar: TabBarSettings
    @EnvironmentObject var router: Router<HomeRoute>
    @StateObject private var viewModel = HomeViewModel()
    
    /// State variables
    @State private var popularMovies: Movies = []
    @State private var movies: Movies = []
    @State private var categorySelected: MoviesType = .nowPlaying
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("What do you want to watch?")
                        .titleStyle()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 32)
                    
                    popularMoviesCarousel
                    moviesCategoriesSection
                }
            }
            .padding(.horizontal, 24)
            .background(Color.background.ignoresSafeArea())
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case .detail(let detail, let video):
                    DetailView(router: router, detail: detail, video: video)
                }
            }
        }
        .onAppear {
            viewModel.initialization(quantity: 6)
        }
        .onReceive(viewModel.$state, perform: evaluateState)
    }
}

// MARK: - View helpers

private extension HomeView {
    
    var popularMoviesCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 40) {
                ForEach(Array(popularMovies.enumerated()), id: \.0) { (index, movie) in
                    if let imageURL = URL(string: "\(ApiConstants.baseImagesURL)\(movie.posterPath)") {
                        ZStack(alignment: .bottomLeading) {
                            RemoteImage(url: imageURL, width: 180, height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            BorderedNumber(number: index + 1)
                        }
                        .onTapGesture {
                            viewModel.getMovieDetail(for: movie.id)
                        }
                    }
                }
            }
        }
        .padding(.bottom, 60)
    }
    
    var moviesCategoriesSection: some View {
        VStack(spacing: 18) {
            HStack(alignment: .top) {
                categorySelector("Now playing", category: .nowPlaying)
                categorySelector("Upcoming", category: .upcoming)
                categorySelector("Top rated", category: .topRated)
            }
            
            moviesGrid
        }
    }
    
    func categorySelector(_ label: String, category: MoviesType) -> some View {
        VStack {
            Text(label)
                .bodyStyle(weight: .semibold)
                .frame(maxWidth: .infinity, alignment: .center)
            if category == categorySelected {
                Rectangle()
                    .frame(height: 4)
                    .foregroundStyle(.gray.opacity(0.2))
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.linear) {
                categorySelected = category
                viewModel.switchCategory(to: category)
            }
        }
    }
    
    var moviesGrid: some View {
        let firstRow = movies.prefix(3)
        let secondRow = movies.suffix(3)
        
        return GeometryReader { geometry in
            Grid(horizontalSpacing: 16, verticalSpacing: 24) {
                GridRow {
                    ForEach(firstRow, id: \.self) { movie in
                        if let imageURL = URL(string: "\(ApiConstants.baseImagesURL)\(movie.posterPath)") {
                                RemoteImage(url: imageURL, width: (geometry.size.width - 32) / 3, height: 155)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .onTapGesture {
                                        viewModel.getMovieDetail(for: movie.id)
                                    }
                        }
                    }
                }
                GridRow {
                    ForEach(secondRow, id: \.self) { movie in
                        if let imageURL = URL(string: "\(ApiConstants.baseImagesURL)\(movie.posterPath)") {
                                RemoteImage(url: imageURL, width: (geometry.size.width - 32) / 3, height: 155)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .onTapGesture {
                                        viewModel.getMovieDetail(for: movie.id)
                                    }
                        }
                    }
                }
            }
        }
        .frame(minHeight: 360)
    }
    
}

// MARK: - Logic helpers

private extension HomeView {
    
    func evaluateState(_ state: HomeState) {
        switch state {
        case .idle:
            break
        case .loadingAllMovies:
            break
        case .didLoadAllMovies(let popular, let nowPlaying):
            popularMovies = popular
            movies = nowPlaying
            
        case .loadingMovies:
            break
        case .didLoadMovies(let movies):
            self.movies = movies
            
        case .loadingDetail:
            break
            
        case .didLoadMovieDetail(let detail, let video):
            router.push(.detail(detail, video))
            
        case .error:
            break
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Router<HomeRoute>())
}
