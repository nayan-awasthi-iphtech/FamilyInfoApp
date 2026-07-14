//
//  FamilyDashboardView.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 13/07/26.
//

import SwiftUI

struct FamilyDashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var appState: AppState
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Member.name, ascending: true)],
        animation: .default
    )
    private var members: FetchedResults<Member>
    
    @State private var isSheetShowing: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Adaptive Background Layer
                LinearGradient(
                    gradient: Gradient(colors: appState.isDarkMode ? [
                        Color(red: 0.12, green: 0.14, blue: 0.17),
                        Color(red: 0.08, green: 0.09, blue: 0.11)
                    ] : [
                        Color("BrandBlue").opacity(0.15),
                        Color(.systemGroupedBackground)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        // 1. Header Hero Panel
                        DashboardHeaderView(isSheetShowing: $isSheetShowing)
                        
                        // 2. Numerical Score Grid Metrics
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            DashboardStatCard(
                                title: "Total Members",
                                value: "\(members.count)",
                                icon: "person.crop.circle",
                                color: Color("BrandBlue")
                            )
                            
                            DashboardStatCard(
                                title: "This Month B'days",
                                value: "\(members.countBirthdaysThisMonth())",
                                icon: "calendar.badge.clock",
                                color: .orange
                            )
                        }
                        .padding(.horizontal)
                        
                        // 3. Horizontal Scope Quick Distribution Breakdown
                        DashboardQuickBreakdownSection(members: members)
                        
                        // 4. Recently Registered Activity Panel
                        DashboardRecentActivitySection(members: Array(members.prefix(3)))
                    }
                    .padding(.bottom, 25)
                }
            }
            .navigationBarHidden(true)
        }
        // Native Half-Detent Analytical Engine Integration
        .sheet(isPresented: $isSheetShowing) {
            RelationshipChartView()
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(appState)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    FamilyDashboardView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(AppState.shared)
}
