//
//  DetailView.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI
import SwiftData

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

// MARK: - Movie detail view

struct DetailView<Route: Hashable>: View {
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var tabBar: TabBarSettings
    
    @StateObject private var viewModel = DetailViewModel()
    @ObservedObject var router: Router<Route>
    
    @State var sheetPresented = false
    
    /// View parameters
    let detail: MovieDetail
    let video: MovieVideo?
    
    @State var isMovieAdded = false
    @Query(sort: [SortDescriptor(\DBMovie.dateAdded, order: .reverse)]) var movies: [DBMovie]
    
    init(router: Router<Route>, detail: MovieDetail, video: MovieVideo?) {
        self.router = router
        self.detail = detail
        self.video = video
    }
    
    var body: some View {
        VStack {
            GenericHeader(label: "Detail") {
                tabBar.toggleTabBar(show: true)
                router.pop()
            }
            
            ScrollView(showsIndicators: false) {
                ZStack {
                    if let backgropImageURL = URL(string: "\(ApiConstants.baseImagesURL)\(detail.backdropPath)") {
                        GeometryReader { geometry in
                            RemoteImage(url: backgropImageURL, width: geometry.size.width, height: 220)
                                .onTapGesture {
                                    sheetPresented = true
                                }
                        }
                    }
                    
                    VStack(spacing: 24) {
                        mainSection
                        additionalInformation
                            .padding(.bottom, 12)
                        overview
                    }
                    .padding(.top, 75)
                    .padding(.horizontal, 32)
                }
                
                Spacer()
                
                CustomButton(label: isMovieAdded ? "Remove from Watchlist" : "Add to Watchlist") {
                    if isMovieAdded {
                        deleteMovie()
                    } else {
                        saveMovie()
                    }
                }
                .padding(.horizontal, 32)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.background.ignoresSafeArea())
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $sheetPresented, content: {
            VStack {
                Text("Official Trailer")
                    .titleStyle()
//                WebView(url: URL(string: "https://player.vimeo.com/video/121450839")!)
                WebView(url: URL(string: "https://www.youtube.com/embed/\(video?.key ?? "")")!)
                    .frame(height: 220)
            }
                .background(Color.background.ignoresSafeArea())
                .presentationDetents([.fraction(0.5)])
        })
        .onAppear {
            print(modelContext.sqliteCommand)
            isMovieAdded = movies.first { $0.id == detail.id } != nil
        }
    }
    
}

// MARK: - View helpers

extension DetailView {
    
    var mainSection: some View {
        HStack(alignment: .center, spacing: 16) {
            if let imageURL = URL(string: "\(ApiConstants.baseImagesURL)\(detail.posterPath)") {
                RemoteImage(url: imageURL, width: 80, height: 155)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            VStack(spacing: 0) {
                ratingChip
                Text(detail.title)
                    .titleStyle(size: 24)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
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
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    var additionalInformation: some View {
        HStack(alignment: .center, spacing: 8) {
            informationItem(icon: "CalendarIcon", label: detail.releaseDate.yearFromDate ?? "-")
            Text("|")
                .lightStyle(size: 20)
            informationItem(icon: "ClockIcon", label: "\(detail.runtime) Minutes")
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
    }
    
}

// MARK: - Helpers

private extension DetailView {
    
    func evaluateState(_ state: DetailState) {
//        switch state {
//        case .idle:
//            break
//        case .loadingDetail:
//            break
//        case .didLoadMovieDetail(let movieDetail, let movieVideo):
//            detail = movieDetail
//            video = movieVideo
//            
//        case .error:
//            break
//        }
    }
    
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
