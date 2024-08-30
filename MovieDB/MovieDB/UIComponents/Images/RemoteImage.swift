//
//  RemoteImage.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

struct RemoteImage: View {
    
    // MARK: - Properties
    let url: URL
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .failure:
                Image(systemName: "photo")
                    .font(.largeTitle)
            case .success(let image):
                image
                    .resizable()
            default:
                ProgressView()
            }
        }
        .frame(width: width, height: height)
    }
}
