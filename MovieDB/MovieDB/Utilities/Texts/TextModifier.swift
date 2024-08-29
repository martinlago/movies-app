//
//  TextModifier.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

// MARK: - Text modifier

struct TextModifier: ViewModifier {
    
    let size: CGFloat
    let foregroundColor: Color
    let weight: Font.Weight
    
    init(size: CGFloat, foregroundColor: Color, weight: Font.Weight) {
        self.size = size
        self.foregroundColor = foregroundColor
        self.weight = weight
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
            .foregroundColor(foregroundColor)
    }
}
