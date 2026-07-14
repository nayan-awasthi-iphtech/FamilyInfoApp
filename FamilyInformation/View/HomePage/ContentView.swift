////
////  ContentView.swift
////  FamilyInformation
////
////  Created by iPHTech4 on 7/7/26.
////
//
//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    
//    @State private var searchText = ""
//    @State private var isPresentingMemberScreen: Bool = false
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Member.name, ascending: true)],
//        animation: .default
//    )
//    private var members: FetchedResults<Member>
//    
//    var body: some View {
//        
//            NavigationStack {
//                ZStack {
//                    LinearGradient(
//                        gradient: Gradient(colors: [
//                            Color("BrandBlue"), .white
//                        ]),
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
//                    .ignoresSafeArea()
//        
//                    ScrollView(.vertical, showsIndicators: false) {
//                        VStack(spacing: 18) {
//                            
//                            HomeHeaderView(memberCount: members.count) {
//                                isPresentingMemberScreen = true
//                            }
//                            
//                            SearchBar(searchText: $searchText)
//                            
//                            BirthdayCardView(birthdayMembers: MemberHelper.todaysBirthdays(from: Array(members)))
//                                .padding(.bottom, 5)
//                            
//                            // Main List Area
//                            MemberListView(searchText: searchText)
//                                .environment(\.managedObjectContext, viewContext)
//                        }
//                        .padding(.bottom, 20)
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                    .navigationBarHidden(true)
//                    .navigationBarTitleDisplayMode(.inline)
//                }
//                .toolbar(.hidden, for: .navigationBar)
//                .navigationDestination(isPresented: $isPresentingMemberScreen) {
//                    AddFamilyMember()
//                        .environment(\.managedObjectContext, viewContext)
//                }
//            }
//        }
//    }
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
//    }
//}
//
//


import SwiftUI
import CoreData

struct ContentView: View {
    @State private var searchText = ""
    @State private var isPresentingMemberScreen: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    // Global environment architecture pattern
    @EnvironmentObject var appState: AppState
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Member.name, ascending: true)],
        animation: .default
    )
    private var members: FetchedResults<Member>
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Corrected: Baseline matches the bottom grounding of dark gradient instead of pitch black
                Color(appState.isDarkMode ? Color(red: 0.14, green: 0.16, blue: 0.18) : Color(UIColor.systemGroupedBackground))
                    .ignoresSafeArea()
                
                // Theme-aware smooth custom gradient mask
                LinearGradient(
                    colors: appState.isDarkMode ? [
                        Color(red: 0.24, green: 0.26, blue: 0.30), // Maximum light slate (Top aura)
                        Color(red: 0.18, green: 0.20, blue: 0.23), // Soft ash grey (Center base)
                        Color(red: 0.14, green: 0.16, blue: 0.18)  // Clean dark grounding (Bottom)
                    ] : [
                        Color.blue.opacity(0.12),
                        Color.cyan.opacity(0.06),
                        Color(UIColor.systemGroupedBackground)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        HomeHeaderView(memberCount: members.count) {
                            isPresentingMemberScreen = true
                        }
                        .padding(.top, 10)
                        
                        SearchBar(searchText: $searchText)
                        
                        BirthdayCardView(birthdayMembers: MemberHelper.todaysBirthdays(from: Array(members)))
                        
                        HStack {
                            // Text color dynamically swaps between clean translucent white and bold secondary slate
                            Text("ALL MEMBERS")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(appState.isDarkMode ? .white.opacity(0.9) : .secondary.opacity(0.8))
                            Spacer()
                            Text("\(members.count)")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(appState.isDarkMode ? .white.opacity(0.9) : .secondary.opacity(0.8))
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 4)
                        
                        MemberListView(searchText: searchText)
                    }
                    .padding(.bottom, 30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $isPresentingMemberScreen) {
                AddFamilyMember()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(AppState.shared)
}
