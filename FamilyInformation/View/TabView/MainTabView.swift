//
//  MainTabView.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 13/07/26.
//

//import SwiftUI
//
//struct MainTabView: View {
//    
//    @Environment(\.managedObjectContext) private var viewContext
//    @State private var selectedTab = 0
//    
//    var body: some View {
//        TabView(selection: $selectedTab){
//            ContentView()
//                .environment(\.managedObjectContext, viewContext)
//                .tabItem{
//                    Label("Home", systemImage: "person.3.fill")
//                }
//                .tag(0)
//        
//            FamilyDashboardView()
//                .environment(\.managedObjectContext, viewContext)
//                .tabItem{
//                    Label("Dashboard", systemImage: "house.fill")
//                }
//                .tag(1)
//        }
//    }
//}
//
//#Preview {
//    MainTabView()
//}


import SwiftUI

struct MainTabView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedTab = 0
    
    // Globally injected theme listener for premium tint syncing
    @EnvironmentObject var appState: AppState
    
    // Custom initialiser to override native UIKit TabBar appearances globally
    init() {
        // Light mode aur dark mode dono ke liye transparent boundary layers aur background mesh colors adjust karne ke liye
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        // Native tab bar component rules inject karne ke liye standard setup
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label("Home", systemImage: "person.3.fill")
                }
                .tag(0)
        
            FamilyDashboardView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    // Kept house.fill for Dashboard as requested 🏠
                    Label("Dashboard", systemImage: "house.fill")
                }
                .tag(1)
        }
        // Fix: Active selection colors dynamically change based on theme matrix
        .accentColor(appState.isDarkMode ? .cyan : Color("BrandBlue"))
        // Fix: Force background texture rendering on native tab layer container
        .tint(appState.isDarkMode ? .cyan : Color("BrandBlue"))
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    MainTabView()
        .environment(\.managedObjectContext, context)
        .environmentObject(AppState.shared)
}
