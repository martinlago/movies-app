//
//  WatchlistView.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI
import SwiftData

struct WatchlistView: View {
    
    @Query(sort: [SortDescriptor(\DBMovie.dateAdded, order: .reverse)]) var movies: [DBMovie]

    var body: some View {
        VStack {
            ForEach(movies) { movie in
                Text(movie.title)
            }
        }
    }
}

#Preview {
    WatchlistView()
}
