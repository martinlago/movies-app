//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import SwiftUI
import SwiftData

@main
struct MovieDBApp: App {
    
    @StateObject private var tabBarSettings = TabBarSettings()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(tabBarSettings)
                .modelContainer(for: DBMovie.self)
        }
    }
}
