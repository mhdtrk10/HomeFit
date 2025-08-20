//
//  WorkoutListViewModel.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 25.07.2025.
//

import Foundation

class WorkoutListViewModel: ObservableObject {
    @Published var days: [WorkoutDay] = []
    @Published var completedDays: Set<Int> = []
    @Published var showBadgeCelebration: Bool = false
    @Published var newlyEarnedBadge: Badge?
    
    private let completedKeyPrefix = "completed_days_" // her plan için ayrı key
    
    
    func cureentBadgeEmoji() -> String {
        let completed = completedDays.count
        
        switch completed {
        case 0: return "🔓"
        case 1...4: return "🥉"
        case 5...9: return "🥈"
        case 10...14: return "🥇"
        case 15...19: return "🏅"
        case 20...24: return "🎖️"
        default: return "🏆"
        }
    }
    
    func currentBadgeTitle() -> String {
        let completed = completedDays.count
        switch completed {
        case 0: return "Henüz rozet yok"
        case 1: return "Başlangıç Rozeti"
        case 5...9: return "İstikrar Rozeti"
        case 10...14: return "Motivasyon Rozeti"
        case 15...19: return "Yükselik Rozeti"
        case 20...24: return "Eşsizlik Rozeti"
        default: return "Efsane Rozeti"
        }
    }
    
    func completionPercentage() -> Double {
        guard !days.isEmpty else { return 0.0 }
        return Double(completedDays.count) / Double(days.count)
    }
    
    func loadPlan(from plan: WorkoutPlanOption) {
        guard let url = Bundle.main.url(forResource: plan.rawValue, withExtension: "json") else {
            print("dosya bulunamadı: \(plan.rawValue)")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedPlan = try JSONDecoder().decode(WorkoutPlan.self, from: data)
            DispatchQueue.main.async {
                self.days = decodedPlan.days
                self.loadCompletedDays(for: plan)
            }
        } catch {
            print("decode hatası: \(error.localizedDescription)")
        }
    }
    
    // İlerleme Takibi (UserDefaults)
    
    private func loadCompletedDays(for plan: WorkoutPlanOption) {
        let key = completedKeyPrefix + plan.rawValue
        if let saved = UserDefaults.standard.array(forKey: key) as? [Int] {
            self.completedDays = Set(saved)
        }
    }
    
    func markDayCompleted(_ day: Int, for plan: WorkoutPlanOption) {
        
        completedDays.insert(day)
        
        // rozet kontrolü
        for badge in BadgeCollectionViewModel().badges {
            newlyEarnedBadge = badge
            showBadgeCelebration = true
            break
        }
        
        saveCompletedDays(for: plan)
    }
    private func saveCompletedDays(for plan: WorkoutPlanOption) {
        let key = completedKeyPrefix + plan.rawValue
        UserDefaults.standard.set(Array(completedDays), forKey: key)
    }
    
    func isDayCompleted(_ day: Int) -> Bool {
        return completedDays.contains(day)
    }
}
