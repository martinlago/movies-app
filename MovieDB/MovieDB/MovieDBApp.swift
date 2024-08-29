//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import SwiftUI

@main
struct MovieDBApp: App {
    
    @StateObject private var tabBarSettings = TabBarSettings()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(tabBarSettings)
        }
    }
    
}
