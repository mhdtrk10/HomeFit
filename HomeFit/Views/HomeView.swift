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
        ZStack {
            Color.blue.opacity(0.2)
                .ignoresSafeArea(edges: .all)
            VStack {
                List {
                    ForEach(viewModel.days) { day in
                        NavigationLink(destination: WorkoutDayDetailView(day: day, plan: plan, viewModel: viewModel)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Gün \(day.day)")
                                        .font(.headline)
                                    Text("\(day.mainExercises.count) egzersiz + 1 bonus")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                }
                                .padding(.vertical,4)
                            }
                            Spacer()
                            
                            
                            
                            // tamamlandıysa simge göster
                            if viewModel.isDayCompleted(day.day) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        .padding(.vertical,4)
                    }
                    .listRowBackground(Color.blue.opacity(0.2))
                    
                }
                
                .scrollContentBackground(.hidden)
                
                .onAppear {
                    viewModel.loadPlan(from: plan)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("ilerleme")
                        .font(.headline)
                        .padding(.horizontal,10)
                    
                    ProgressView(value: viewModel.completionPercentage())
                        .padding(.horizontal,10)
                    
                    Text("%\(Int(viewModel.completionPercentage()*100)) tamamlandı")
                        .padding(.horizontal,10)
                }
                .padding(.top)
                VStack(spacing: 8) {
                    Text("Rozetin")
                        .font(.headline)
                    Text(viewModel.cureentBadgeEmoji())
                        .font(.system(size: 50))
                    Text(viewModel.currentBadgeTitle())
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
            }
        }
        .navigationTitle(plan.title)
    }
}

#Preview {
    HomeView()
}
