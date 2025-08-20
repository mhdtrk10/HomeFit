//
//  BadgeCollectionViewModel.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 18.08.2025.
//

import Foundation

class BadgeCollectionViewModel: ObservableObject {
    @Published var badges: [Badge] = [
        Badge(title: "5 gün", emoji: "🥉", requiredDays: 5),
        Badge(title: "10 gün", emoji: "🥈", requiredDays: 10),
        Badge(title: "15 gün", emoji: "🥇", requiredDays: 15),
        Badge(title: "20 gün", emoji: "🏅", requiredDays: 20),
        Badge(title: "25 gün", emoji: "🎖️", requiredDays: 25),
        Badge(title: "30 gün", emoji: "🏆", requiredDays: 30),
    ]
    
    func hasEarned(badge: Badge,completedDays: Int) -> Bool {
        return completedDays >= badge.requiredDays
    }
}
