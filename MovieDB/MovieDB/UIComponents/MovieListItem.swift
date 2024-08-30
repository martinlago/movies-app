//
//  MovieListItem.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import SwiftUI

struct MovieListItem<I: View>: View {
    
    let title: String
    let punctuation: Float
    let genre: String
    let releaseYear: String
    let duration: Int?
    let image: I
    let onTap: () -> Void
    
    init(title: String, punctuation: Float, genre: String, releaseYear: String, duration: Int? = nil, image: I, onTap: @escaping () -> Void) {
        self.title = title
        self.punctuation = punctuation
        self.genre = genre
        self.releaseYear = releaseYear
        self.duration = duration
        self.image = image
        self.onTap = onTap
    }
    
    var body: some View {
        HStack(alignment: .center) {
            image
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .titleStyle(size: 17)
                    .lineLimit(1)
                    .padding(.bottom, 12)
                listItem(color: .mainOrange, icon: "StarIcon", label: String(punctuation.oneDecimal))
                listItem(icon: "TicketIcon", label: genre)
                listItem(icon: "CalendarIcon", label: releaseYear)
                if let duration = duration {
                    listItem(icon: "ClockIcon", label: "\(duration) minutes")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.white)
        }
        .contentShape(.rect)
        .onTapGesture {
            onTap()
        }
    }
}

// MARK: - View helpers

private extension MovieListItem {
    
    func listItem(color: Color = .white, icon: String, label: String) -> some View {
        HStack {
            CustomImage(
                name: icon,
                width: 16,
                height: 16,
                color: color
            )
            Text(label)
                .bodyStyle(color: color)
        }
    }
    
}

#Preview {
    MovieListItem(
        title: "Spiderman",
        punctuation: 9.4,
        genre: "Action",
        releaseYear: "2019",
        duration: 124,
        image: Image(systemName: "photo")
    ) {}
        .background(Color.background.ignoresSafeArea())
}
