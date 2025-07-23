//
//  WorkoutPlanLoader.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 18.07.2025.
//

import Foundation

final class WorkoutPlanLoader {
    
    static func loadPlan(named fileName: String) -> WorkoutPlan? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("json dosyası bulunamadı: \(fileName)")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let plan = try JSONDecoder().decode(WorkoutPlan.self, from: data)
            return plan
        } catch {
            print("json parse hatası: \(error.localizedDescription)")
            return nil
        }
    }
}
