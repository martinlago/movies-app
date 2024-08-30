//
//  DetailView.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI
import SwiftData

// MARK: - Movie detail view

struct DetailView<Route: Hashable>: View {
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var tabBar: TabBarSettings
    
    @ObservedObject var router: Router<Route>
    
    @State var sheetPresented = false
    
    /// View parameters
    let detail: MovieDetail
    let video: MovieVideo?
    let posterData: Data?
    let backdropData: Data?
    
    @State var isMovieAdded = false
    @Query(sort: [SortDescriptor(\DBMovie.dateAdded, order: .reverse)]) var movies: [DBMovie]
    
    init(router: Router<Route>, detail: MovieDetail, video: MovieVideo?, posterData: Data? = nil, backdropData: Data? = nil) {
        self.router = router
        self.detail = detail
        self.video = video
        self.posterData = posterData
        self.backdropData = backdropData
    }
    
    var body: some View {
        VStack {
            GenericHeader(label: "Detail") {
                router.pop()
            }
            
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ZStack(alignment: .top) {
                                GenericImage(
                                    data: backdropData,
                                    url: detail.backdropPath,
                                    width: geometry.size.width,
                                    height: 220,
                                    clipImage: false
                                )
                            
                            videoButton
                            VStack(spacing: 24) {
                                mainSection
                                additionalInformation
                                    .padding(.bottom, 12)
                                overview
                            }
                            .padding(.top, 140)
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer()
                            .frame(minHeight: 24)
                        
                        CustomButton(label: isMovieAdded ? "Remove from Watchlist" : "Add to Watchlist") {
                            if isMovieAdded {
                                deleteMovie()
                            } else {
                                saveMovie()
                            }
                        }
                        .padding(.horizontal, 32)
                    }
                    .frame(minHeight: geometry.size.height)
                }
            }
        }
        .background(Color.background.ignoresSafeArea())
        .navigationBarBackButtonHidden()
        .onAppear {
            isMovieAdded = movies.first { $0.id == detail.id } != nil
        }
        .sheet(isPresented: $sheetPresented) {
            if let videoId = video?.key, let site = video?.site {
                VideoPlayer(videoId: videoId, fromYoutube: site == "YouTube")
            }
        }
    }
    
}

// MARK: - View helpers

extension DetailView {
    
    var mainSection: some View {
        HStack(alignment: .center, spacing: 16) {
            GenericImage(data: posterData, url: detail.posterPath, width: 110, height: 155)
            
            VStack(spacing: 16) {
                ratingChip
                Text(detail.title)
                    .titleStyle(size: 24)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .frame(height: 155)
    }
    
    var ratingChip: some View {
        HStack {
            CustomImage(
                name: "StarIcon",
                width: 18,
                height: 18,
                color: .mainOrange
            )
            Text(String(detail.voteAverage.oneDecimal))
                .bodyStyle(color: .mainOrange, weight: .semibold)
        }
        .padding(8)
        .background(
            Capsule()
                .fill(Color.background)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    var additionalInformation: some View {
        HStack(alignment: .center, spacing: 8) {
            informationItem(icon: "CalendarIcon", label: detail.releaseDate.yearFromDate ?? "-")
            Text("|")
                .lightStyle(size: 20)
            informationItem(icon: "ClockIcon", label: "\(detail.runtime) minutes")
            Text("|")
                .lightStyle(size: 20)
            informationItem(icon: "TicketIcon", label: detail.genres.first?.name ?? "-")
        }
    }
    
    func informationItem(icon: String, label: String) -> some View {
        HStack {
            CustomImage(
                name: icon,
                width: 16,
                height: 16,
                color: .gray
            )
            Text(label)
                .lightStyle()
        }
    }
    
    var overview: some View {
        Text(detail.overview)
            .bodyStyle()
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
    
    @ViewBuilder
    var videoButton: some View {
        if let _ = video {
            Image(systemName: "play.circle")
                .font(.system(size: 80))
                .zIndex(500)
                .onTapGesture {
                    sheetPresented = true
                }
                .padding(.top, 70)
        }
    }
    
}

// MARK: - Helpers

private extension DetailView {
    
}

#Preview {
    DetailView(
        router: Router<HomeRoute>(),
        detail: MovieDetail(
            id: 157336,
            title: "Interstellar",
            overview: "The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.",
            releaseDate: "2014-11-05",
            posterPath: "/xJHokMbljvjADYdit5fK5VQsXEG.jpg",
            backdropPath: "/xJHokMbljvjADYdit5fK5VQsXEG.jpg",
            voteAverage: 9.5698,
            genres: [
                Genre(id: 1, name: "Action")
            ],
            runtime: 150
        ),
        video: nil
    )
}
