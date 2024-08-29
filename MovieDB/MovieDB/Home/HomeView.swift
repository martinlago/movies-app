//
//  HomeView.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var router: Router<HomeRoute>
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Text("What do you want to watch?")
                    .font(.title)
                Spacer()
                
                Button("Navigate") {
                    router.push(.detail)
                }
            }
            .background(Color.background.ignoresSafeArea())
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case .detail:
                    Text("Detail")
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
