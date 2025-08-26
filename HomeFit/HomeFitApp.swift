//
//  HomeFitApp.swift
//  HomeFit
//
//  Created by Mehdi Oturak on 18.07.2025.
//

import SwiftUI

@main
struct HomeFitApp: App {
    let persistenceController = PersistenceController.shared

    
    
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tint(.black)
            
        }
    }
}
