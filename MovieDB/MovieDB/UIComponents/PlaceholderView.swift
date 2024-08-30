//
//  PlaceholderView.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

struct PlaceholderView: View {
    
    let image: String
    let label: String
    let description: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            CustomImage(name: image, width: 75, height: 75)
            Group {
                Text(label)
                    .bodyStyle(size: 18)
                Text(description)
                    .lightStyle()
            }
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: 250, maxHeight: .infinity)
    }
}

#Preview {
    VStack {
        PlaceholderView(
            image: "EmptySearch",
            label: "We couldn't find any movies regarding your search",
            description: "Try with another name"
        )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.background.ignoresSafeArea())
}
