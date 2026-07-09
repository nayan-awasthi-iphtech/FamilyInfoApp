//
//  ContentView.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/7/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var searchText = "hi"
    
    @Environment (\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Member.name, ascending: true)],
        animation:.default
    )

    private var members:FetchedResults<Member>
    
    var filteredMembers: [Member]{
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return Array(members)
        }
        
        return members.filter{
            ($0.name ?? "").localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("BrandBlue"),.white
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            VStack(spacing:18){
                HStack(alignment: .center){
                VStack(alignment: .center,spacing: 4){
                    Text("My Family")
                        .font(.system(size: 30, weight: .bold))
                    Text("❤️ \(members.count) Members")
                        .font(.subheadline)
                            
                }
                .padding(.horizontal)
                Spacer()
                    NavigationLink(destination:AddFamilyMember().environment(\.managedObjectContext, viewContext)){
                    
                    ZStack {

                                Circle()
                                    .fill(Color("BrandBlue"))
                                    .frame(width: 50, height: 50)

                                Image(systemName: "plus")
                                    .font(.title3)
                                    .padding()
                            }
                           .padding(.trailing,10)
                        }
                    }
                      .padding(.horizontal)
                      .padding(.top,10)
                
                SearchBar(searchText: $searchText)
                
                BirthdayCardView(birthdayMembers: MemberHelper.todaysBirthdays(from: Array(members)))
                    .padding(.bottom, 5)
                
                MemberListView(searchText: searchText)
                    .environment(\.managedObjectContext, viewContext)
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
