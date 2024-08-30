//
//  GenericImage.swift
//  MovieDB
//
//  Created by Martin Lago on 30/8/24.
//

import SwiftUI

struct GenericImage: View {
    
    let data: Data?
    let url: String?
    let width: CGFloat
    let height: CGFloat
    let clipImage: Bool
    
    init(data: Data? = nil, url: String? = nil, width: CGFloat, height: CGFloat, clipImage: Bool = true) {
        self.data = data
        self.url = url
        self.width = width
        self.height = height
        self.clipImage = clipImage
    }
    
    var body: some View {
        ZStack {
            if let data = data, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: width, height: height)
            } else if let urlPath = url, let url = URL(string: "\(ApiConstants.baseImagesURL)\(urlPath)") {
                RemoteImage(url: url, width: width, height: height)
            } else {
                Image(systemName: "photo")
                    .font(.largeTitle)
            }
        }
        .frame(width: width, height: height)
        .clipShape(.rect(cornerRadius: clipImage ? 25 : 0))
    }
}
