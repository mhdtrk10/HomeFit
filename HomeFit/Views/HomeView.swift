//
//  HomeView.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 24.07.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.55)
                    .ignoresSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("HomeFit")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 40)
                    Spacer()
                    Text("Hedefini Seç!")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(.bottom, 50)
                    
                    
                    // Plan kartları
                    
                    ForEach(WorkoutPlanOption.allCases, id: \.self) { plan in
                        NavigationLink(destination: WorkoutListView(plan: plan)) {
                            HStack {
                                Text(plan.emoji + " " + plan.title)
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(Color.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .padding()
                            }
                            .frame(maxWidth:.infinity)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                        
                    }
                    Spacer()
                }
            }
        }
    }
}
enum WorkoutPlanOption: String, CaseIterable {
    case plan15 = "homefit_week1"
    case plan30 = "homefit_week2"
    case plan45 = "homefit_week3"
    case plan60 = "homefit_week4"
    
    var title: String {
        switch self {
        case .plan15: return "15 günlük plan"
        case .plan30: return "30 günlük plan"
        case .plan45: return "45 günlük plan"
        case .plan60: return "60 günlük plan"
        }
    }
    
    var emoji: String {
        switch self {
        case .plan15: return "🔥"
        case .plan30: return "⚡"
        case .plan45: return "💪"
        case .plan60: return "🏆"
        }
    }
}

struct WorkoutListView: View {
    
    let plan: WorkoutPlanOption
    @StateObject private var viewModel = WorkoutListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.days) { day in
                NavigationLink(destination: WorkoutDayDetailView(day: day)) {
                    VStack(alignment: .leading) {
                        Text("Gün \(day.day)")
                            .font(.headline)
                        Text("\(day.mainExercises.count) egzersiz + 1 bonus")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            
                    }
                    .padding(.vertical,4)
                }
            }
        }
        .navigationTitle(plan.title)
        .onAppear {
            viewModel.loadPlan(from: plan)
        }
    }
}

#Preview {
    HomeView()
}
