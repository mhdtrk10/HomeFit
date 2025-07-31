//
//  BadgeCelebrationView.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 31.07.2025.
//

import SwiftUI

struct BadgeCelebrationView: View {
    
    let badgeEmoji: String
    let badgeTitle: String
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
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
            
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}


