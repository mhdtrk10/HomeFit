//
//  WorkoutViewModel.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 21.07.2025.
//

import Foundation

@MainActor

final class WorkoutViewModel: ObservableObject {
    @Published var workoutPlan: WorkoutPlan?
    @Published var selectedDay: WorkoutDay?
    
    init () {
        loadPlan()
    }
    
    func loadPlan() {
        workoutPlan = WorkoutPlanLoader.loadPlan(named: "homefit_week1")
        
    }
    
    func selectDay(_ day: WorkoutDay) {
        selectedDay = day
    }
}
