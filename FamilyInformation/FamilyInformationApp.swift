//
//  FamilyInformationApp.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/7/26.


import SwiftUI

@main
struct FamilyInformationApp: App {
    let persistenceController = PersistenceController.shared
    
    // Root level source of truth initialization
    @StateObject private var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                // Injected globally into the app environment stack
                .environmentObject(appState)
                .preferredColorScheme(appState.isDarkMode ? .dark : .light)
                .onAppear {
                    NotificationManager.shared.requestAuthorization()
                }
        }
    }
}
