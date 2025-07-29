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
    
    private let completedKeyPrefix = "completed_days_" // her plan için ayrı key
    
    
    
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
