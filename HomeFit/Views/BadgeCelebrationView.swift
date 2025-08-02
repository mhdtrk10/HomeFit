//
//  BadgeCelebrationView.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 31.07.2025.
//

import SwiftUI
import ConfettiSwiftUI

struct BadgeCelebrationView: View {
    
    let badgeEmoji: String
    let badgeTitle: String
    @State private var confettiTrigger = 0
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            
            Text("Tebrikler!")
                .font(.largeTitle)
                .bold()
            
            Text("Yeni Rozet Kazandın:")
                .font(.title2)
            
            Text(badgeEmoji)
                .font(.system(size: 80))
            
            Text(badgeTitle)
                .font(.title3)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button("Tamam") {
                dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(12)
            .confettiCannon(
                trigger: $confettiTrigger,
                num: 50,
                colors: [.pink, .green, .orange],
                rainHeight: 600,
                openingAngle: Angle(degrees: 60),
                closingAngle: Angle(degrees: 120),
                radius: 300
            )
            .onAppear {
                confettiTrigger += 1
            }
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}


