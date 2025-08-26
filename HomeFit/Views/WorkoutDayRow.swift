//
//  WorkoutDayRow.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 26.08.2025.
//

import SwiftUI

struct WorkoutDayRow: View {
    let day: WorkoutDay
    let isCompleted: Bool
    @State private var pressed = false
    
    var body: some View {
        HStack {
            Text("Gün \(day.day)")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "chevron.right")
                .foregroundColor(isCompleted ? .green : .white.opacity(0.7))
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .scaleEffect(pressed ? 0.97 : 1) // tıklayınca küçülme efekti
        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: pressed)
        .onTapGesture {
            pressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                pressed = false
            }
        }
    }
}

