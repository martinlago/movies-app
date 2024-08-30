//
//  VideoPlayer.swift
//  MovieDB
//
//  Created by Martin Lago on 30/8/24.
//

import SwiftUI

// MARK: - Video player content

struct VideoPlayer: View {
    
    let videoId: String
    let fromYoutube: Bool
    
    var body: some View {
        VStack {
            Text("Official Trailer")
                .titleStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            WebView(url: videoURL!)
                .frame(height: 300)
        }
        .frame(height: 370)
        .presentationDetents([.height(370)])
        .background(Color.background.ignoresSafeArea())
    }
}

// MARK: - Helpers

private extension VideoPlayer {
    
    var videoURL: URL? {
        fromYoutube
        ? URL(string: "https://www.youtube.com/embed/\(videoId)")
        : URL(string: "https://player.vimeo.com/video/\(videoId)")
    }
    
}

#Preview {
    VideoPlayer(videoId: "", fromYoutube: true)
}
