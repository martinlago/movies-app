//
//  CustomImage.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import SwiftUI

struct CustomImage: View {
    
    let name: String
    let width: CGFloat
    let height: CGFloat
    let color: Color?
    
    init(name: String, width: CGFloat = 18, height: CGFloat = 18, color: Color? = nil) {
        self.name = name
        self.width = width
        self.height = height
        self.color = color
    }
    
    var body: some View {
        Image(name)
            .resizable()
            .frame(width: width, height: height)
            .foregroundColor(color)
    }
}
