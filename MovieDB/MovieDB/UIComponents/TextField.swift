//
//  TextField.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

// MARK: - Custom TextField component

struct CustomTextField: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("ola", text: $text)
                .font(.system(size: 16, design: .rounded))
                .foregroundStyle(.white)
            CustomImage(name: "SearchIcon", width: 22, height: 22, color: .gray)
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: 0, y: 1, z: 0)
                )
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    @State var text = ""
    return ZStack {
        CustomTextField(text: $text)
            .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    .background(Color.background.ignoresSafeArea())
}
