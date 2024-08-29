//
//  MainView.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import SwiftUI

struct MainView: View {
    
    /// Routers for each tab
    @StateObject private var homeRouter: Router<HomeRoute> = Router()
    @StateObject private var searchRouter: Router<SearchRoute> = Router()
    @StateObject private var watchlistRouter: Router<WatchlistRoute> = Router()
    
    /// Tab Bar management
    @EnvironmentObject var tabBar: TabBarSettings
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $tabBar.selectedTab) {
                ForEach(TabItem.allCases, id: \.self) { item in
                    tabItemView(item: item)
                        .tag(item)
                }
            }

            TabBarView()
        }
        .background(Color.background.ignoresSafeArea())
    }
}

// MARK: - Helpers

private extension MainView {
    
    @ViewBuilder
    func tabItemView(item: TabItem) -> some View {
        switch item {
        case .home:
            HomeView()
                .environmentObject(homeRouter)
        case .search:
            SearchView()
                .environmentObject(searchRouter)
        case .saved:
            WatchlistView()
                .environmentObject(watchlistRouter)
        }
    }
    
}

#Preview {
    MainView()
}
