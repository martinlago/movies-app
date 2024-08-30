//
//  TabItem.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

enum TabItem: CaseIterable, Equatable {
    case home
    case search
    case saved
    
    var label: String {
        switch self {
        case .home:
            "Home"
        case .search:
            "Search"
        case .saved:
            "Watchlist"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            "HomeIcon"
        case .search:
            "SearchIcon"
        case .saved:
            "WatchlistIcon"
        }
    }
}
