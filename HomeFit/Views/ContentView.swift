//
//  ContentView.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 18.07.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject private var viewModel = WorkoutViewModel()
    @State private var showDayDetail = false
    
    var body: some View {
       NavigationView {
            VStack {
               if let plan = viewModel.workoutPlan {
                   List(plan.days) { day in
                       Button(action: {
                           viewModel.selectDay(day)
                           showDayDetail = true
                       }) {
                           HStack {
                               Text("Gün \(day.day)")
                                   .font(.headline)
                               Spacer()
                               Image(systemName: "chevron.right")
                                   .foregroundColor(.gray)
                           }
                       }
                   }
                   .listStyle(.insetGrouped)
                } else {
                   ProgressView("yükleniyor..")
               }
           }
            .navigationTitle("HomeFit")
            .sheet(isPresented: $showDayDetail) {
                if let selectedDay = viewModel.selectedDay {
                    WorkoutDayDetailView(day: selectedDay)
                }
            }
        }
    }

    }


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
