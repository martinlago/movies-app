//
//  TabBarView.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import SwiftUI

// MARK: - Tab Bar component

struct TabBarView: View {
    
    @EnvironmentObject var tabBar: TabBarSettings
    
    var body: some View {
        if tabBar.isTabBarShown {
            VStack(spacing: 16) {
                Rectangle()
                    .foregroundStyle(Color.mainBlue)
                    .frame(height: 1)
                
                HStack(alignment: .center) {
                    ForEach(TabItem.allCases, id: \.self) { item in
                        tabItem(item: item)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .onTapGesture {
                                withAnimation {
                                    tabBar.selectedTab = item
                                }
                            }
                    }
                }
            }
            .background(Color.background.ignoresSafeArea())
        }
    }
}

// MARK: - View helpers

private extension TabBarView {
    
    func tabItem(item: TabItem) -> some View {
        let isSelectedItem = tabBar.selectedTab == item
        
        return VStack(alignment: .center, spacing: 9) {
            CustomImage(
                name: item.icon,
                width: 22,
                height: 22,
                color: isSelectedItem ? Color.mainBlue : Color.gray
            )
            Text(item.label)
                .font(.system(size: 12, design: .rounded))
                .foregroundStyle(isSelectedItem ? Color.mainBlue : Color.gray)
        }
    }
    
}

#Preview {
    VStack {
        Spacer()
        TabBarView()
    }
    .background {
        Color.background.ignoresSafeArea()
    }
}
