//
//  WorkoutModels.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 18.07.2025.
//

import Foundation
    // planın genel adı ve günlerin listesi
struct WorkoutPlan: Decodable {
    let planName: String
    let days: [WorkoutDay]
}
    // her bir günün verisi
struct WorkoutDay: Decodable, Identifiable {
    let id = UUID()
    let day: Int
    let mainExercises: [Exercise]
    let bonusExercise: Exercise
}
    // egersizlerin verisi
struct Exercise: Decodable,Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let duration: String
    let videoName: String
    let videoURL: String?
    let premium: Bool
}


