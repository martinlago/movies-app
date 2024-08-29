//
//  BorderedNumber.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

struct BorderedNumber: View {
    
    let number: Int
    
    var body: some View {
        ZStack {
            Text(String(number))
                .bodyStyle(size: 150, color: .mainBlue, weight: .medium)
            Text(String(number))
                .bodyStyle(size: 150, color: .background)
                .scaleEffect(0.99)
        }
    }
}

#Preview {
    VStack {
        BorderedNumber(number: 1)
        BorderedNumber(number: 2)
        BorderedNumber(number: 3)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.background.ignoresSafeArea())
        
}
