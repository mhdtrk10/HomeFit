//
//  BadgeCollectionView.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 18.08.2025.
//

import SwiftUI

struct BadgeCollectionView: View {
    @ObservedObject var viewModel: BadgeCollectionViewModel
    let completedDays: Int
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(viewModel.badges) { badge in
                    VStack {
                        Text(badge.emoji)
                            .font(.system(size: 48))
                            .opacity(viewModel.hasEarned(badge: badge, completedDays: completedDays) ? 1.0 : 0.3)
                            
                        Text(badge.title)
                            .font(.subheadline)
                            .foregroundColor(viewModel.hasEarned(badge: badge, completedDays: completedDays) ? .primary : .gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Rozet Koleksiyonu")
    }
}


