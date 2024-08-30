//
//  GenericHeader.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

struct GenericHeader: View {
    
    let label: String
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Image(systemName: "chevron.left")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.white)
                .onTapGesture {
                    action()
                }
            
            
            Text(label)
                .bodyStyle(size: 17, weight: .semibold)
        }
        .padding(.top, 20)
        .padding(.horizontal, 24)
    }
}

#Preview {
    VStack {
        GenericHeader(label: "Detail") {
            print("Go back!")
        }
        Spacer()
    }
    .background(Color.background.ignoresSafeArea())
}
