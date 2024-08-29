//
//  Text+Styles.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

// MARK: - Text styles

extension Text {
    
    func titleStyle(
        size: CGFloat = 22,
        color: Color = .white,
        weight: Font.Weight = .semibold
    ) -> some View {
        modifier(
            TextModifier(size: size, foregroundColor: color, weight: weight)
        )
    }
    
    func bodyStyle(
        size: CGFloat = 16,
        color: Color = .white,
        weight: Font.Weight = .regular
    ) -> some View {
        modifier(
            TextModifier(size: size, foregroundColor: color, weight: weight)
        )
    }
    
    func lightStyle(
        size: CGFloat = 15,
        color: Color = .gray,
        weight: Font.Weight = .regular
    ) -> some View {
        modifier(
            TextModifier(size: size, foregroundColor: color, weight: weight)
        )
    }
    
}
