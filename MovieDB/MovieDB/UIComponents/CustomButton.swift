//
//  CustomButton.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

// MARK: - Custom button component

struct CustomButton: View {
    
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .bodyStyle(weight: .semibold)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .fill(Color.mainBlue)
                )
        }
    }
}

#Preview {
    CustomButton(label: "Save") {
        
    }
}
