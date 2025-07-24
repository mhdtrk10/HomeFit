//
//  WorkoutListViewModel.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 25.07.2025.
//

import Foundation

class WorkoutListViewModel: ObservableObject {
    @Published var days: [WorkoutDay] = []
    
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
            }
        } catch {
            print("decode hatası: \(error.localizedDescription)")
        }
    }
}
