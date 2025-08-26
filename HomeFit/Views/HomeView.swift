//
//  HomeView.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 24.07.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("HomeFit")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 40)
                    Image("anasayfa")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .padding(.horizontal)
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
        .tint(.black)
    }
}
enum WorkoutPlanOption: String, CaseIterable {
    case plan15 = "homefit_15days"
    case plan30 = "homefit_30day"
    case plan45 = "homefit_week1"
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
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(.all)
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
                                            .foregroundColor(.black.opacity(0.7))
                                        
                                    }
                                    .padding(.vertical,4)
                                }
                                
                                
                                
                                
                                // tamamlandıysa simge göster
                                if viewModel.isDayCompleted(day.day) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            .padding(.vertical,4)
                            .tint(.black)
                        }
                        .listRowBackground(Color.white.opacity(0.17))
                        
                        
                    }
                    .cornerRadius(20)
                    .frame(width: .infinity,height: 430)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .navigationBarTitleDisplayMode(.inline)
                    
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
                        
                        NavigationLink("Rozetlerim") {
                            BadgeCollectionView(viewModel: BadgeCollectionViewModel(), completedDays: viewModel.completedDays.count)
                        }
                        .frame(width: 95, height: 40)
                        .foregroundColor(Color.black)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(10)
                        .padding()
                    }
                    .padding(.top)
                    VStack(spacing: 8) {
                        Text("Rozetin")
                            .font(.headline)
                        Text(viewModel.cureentBadgeEmoji())
                            .font(.system(size: 50))
                        Text(viewModel.currentBadgeTitle())
                            .font(.subheadline)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                }
            }
            .navigationTitle(plan.title)
        }
    }
}

#Preview {
    HomeView()
}
