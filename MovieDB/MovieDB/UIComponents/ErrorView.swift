//
//  ErrorView.swift
//  MovieDB
//
//  Created by Martin Lago on 30/8/24.
//

import SwiftUI

struct ErrorView: View {
    
    var body: some View {
        VStack {
            Spacer()
            PlaceholderView(
                image: "Error",
                label: "Something went wrong",
                description: "Please, try again later!"
            )
        }
    }
}

#Preview {
    VStack {
        ErrorView()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.background.ignoresSafeArea())
}
