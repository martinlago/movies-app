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
    @State private var isLoading = false
    @State private var showError = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack {
                        Text("What do you want to watch?")
                            .titleStyle()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .horizontal], 24)
                        
                        if showError {
                            ErrorView()
                        } else if isLoading {
                            loadingView
                            
                        } else {
                            popularMoviesCarousel
                            moviesCategoriesSection
                        }
                    }
                    .frame(minHeight: geometry.size.height)
                }
            }
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
    
    @ViewBuilder
    var loadingView: some View {
        Spacer()
        ProgressView()
        Spacer()
    }
    
    var popularMoviesCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 40) {
                ForEach(Array(popularMovies.enumerated()), id: \.0) { (index, movie) in
                    ZStack(alignment: .topLeading) {
                        GenericImage(url: movie.posterPath, width: 180, height: 250)
                        BorderedNumber(number: index + 1)
                            .offset(y: 180)
                    }
                    .frame(height: 325)
                    .padding(.trailing, index == popularMovies.count - 1 ? 24 : 0)
                    .onTapGesture {
                        viewModel.getMovieDetail(for: movie.id)
                    }
                }
            }
        }
        .padding(.leading, 24)
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
        .padding(.top, 40)
        .padding(.horizontal, 24)
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
                        GenericImage(url: movie.posterPath, width: (geometry.size.width - 32) / 3, height: 155)
                            .onTapGesture {
                                viewModel.getMovieDetail(for: movie.id)
                            }
                    }
                    
                }
                GridRow {
                    ForEach(secondRow, id: \.self) { movie in
                        GenericImage(url: movie.posterPath, width: (geometry.size.width - 32) / 3, height: 155)
                            .onTapGesture {
                                viewModel.getMovieDetail(for: movie.id)
                            }
                    }
                    
                }
            }
        }
            .frame(height: 360)
        }
        
    }
    
    // MARK: - Logic helpers
    
    private extension HomeView {
        
        func evaluateState(_ state: HomeState) {
            switch state {
            case .idle:
                break
            case .loadingAllMovies:
                isLoading = true
                
            case .didLoadAllMovies(let popular, let nowPlaying):
                isLoading = false
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
                showError = true
                isLoading = false
            }
        }
    }
    
    #Preview {
        HomeView()
            .environmentObject(Router<HomeRoute>())
    }
