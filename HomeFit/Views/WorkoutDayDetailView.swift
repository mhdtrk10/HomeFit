//
//  WorkoutDayDetailView.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 21.07.2025.
//

import SwiftUI
import AVKit
struct WorkoutDayDetailView: View {
    
    let day: WorkoutDay
    let plan: WorkoutPlanOption
    @ObservedObject var viewModel: WorkoutListViewModel
    
    @State private var selectedVideoURL: URL?
    @State private var showVideoPlayer = false
    @State private var showPremiumAlert = false
    
    var body: some View {
        NavigationView {
            List {
                // ana egzersiz
                Section(header: Text("Egzersizler")) {
                    ForEach(day.mainExercises) { exercise in
                        Button {
                            if let urlString = exercise.videoURL,
                               let url = URL(string: urlString) {
                                selectedVideoURL = url
                                showVideoPlayer = true
                            }
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(exercise.title)
                                    .font(.headline)
                                Text(exercise.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("⏱ \(exercise.duration)")
                                    .font(.caption)
                            }
                            .padding(.vertical,4)
                        }
                    }
                }
                // bonus egzersiz
                Section(header: Text("Bonus Egzersiz")) {
                    Button {
                        if day.bonusExercise.premium {
                            // premium kilitli uyarısı
                            
                            showPremiumAlert = true
                        } else if let urlString = day.bonusExercise.videoURL,
                                  let url = URL(string: urlString){
                            selectedVideoURL = url
                            showVideoPlayer = true
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(day.bonusExercise.title)
                                .font(.headline)
                            Text(day.bonusExercise.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("⏱ \(day.bonusExercise.duration)")
                                .font(.caption)
                            if day.bonusExercise.premium {
                                Text("🔒 Premium hareket")
                                    .font(.caption2)
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding(.vertical,4)
                    }
                }
            }
            .navigationTitle("Gün\(day.day)")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showVideoPlayer) {
                if let url = selectedVideoURL {
                    VideoPlayer(player: AVPlayer(url: url))
                        .edgesIgnoringSafeArea(.all)
                        
                } else {
                    Text("video yüklenemedi.")
                }
            }
            .alert("Premium İçerik", isPresented: $showPremiumAlert) {
                Button("Tamam",role: .cancel) {
                    
                }
            } message: {
                Text("Bu özel egzersiz sadece premium kullanıcılar içindir.")
            }
           
        }
        Button {
            viewModel.markDayCompleted(day.day, for: plan)
        } label: {
            Text("✅ Bu Günü Tamamladım")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
        }
        .disabled(viewModel.isDayCompleted(day.day))
        .padding(.bottom)
        
    }
}


