//
//  MainTabView.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 13/07/26.
//

import SwiftUI

struct MainTabView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            ContentView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
        
            FamilyDashboardView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem{
                    Label("Dashboard", systemImage: "house.fill")
                }
                .tag(1)
        }
    }
}

#Preview {
    MainTabView()
}
