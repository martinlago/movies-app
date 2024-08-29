//
//  TabBarSettings.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import SwiftUI

// MARK: - Tab Bar settings helper

class TabBarSettings: ObservableObject {
    
    @Published var selectedTab: TabItem = .home
    @Published var isTabBarShown = true
    
    public init() {}
    
}
