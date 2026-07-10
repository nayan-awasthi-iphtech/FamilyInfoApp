//
//  ContentView.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/7/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var isPresentingMemberScreen: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Member.name, ascending: true)],
        animation: .default
    )
    private var members: FetchedResults<Member>
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("BrandBlue"), .white
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // FIXED: Pure content area ko ScrollView mein daala taaki dynamic layouts screen se bahar na bhaagein
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 18) {
                        
                        HomeHeaderView(memberCount: members.count) {
                            isPresentingMemberScreen = true
                        }
                        
                        SearchBar(searchText: $searchText)
                        
                        BirthdayCardView(birthdayMembers: MemberHelper.todaysBirthdays(from: Array(members)))
                            .padding(.bottom, 5)
                        
                        // Main List Area
                        MemberListView(searchText: searchText)
                            .environment(\.managedObjectContext, viewContext)
                    }
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationDestination(isPresented: $isPresentingMemberScreen) {
                AddFamilyMember()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
