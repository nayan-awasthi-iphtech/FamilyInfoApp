//
//  FamilyDashboardView.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 13/07/26.
//

import SwiftUI

struct FamilyDashboardView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Member.name, ascending: true)],
    animation: .default
    )
    
    private var members: FetchedResults<Member>
    
    var body: some View {
        VStack(spacing:5){
            NavigationStack{
                ZStack {
                    LinearGradient(
                      gradient: Gradient(colors: [
                          Color("BrandBlue").opacity(0.15),
                           Color(.systemGroupedBackground)
                           ]),
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing
                        )
                        .ignoresSafeArea()
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing:24){
                            
                            VStack(alignment: .leading, spacing: 4){
                                Text("Family Overview")
                                    .font(.system(.largeTitle,design: .rounded))
                                    .bold()
                                    .foregroundColor(.primary)
                                
                                Text("Summary and stats of your family networks.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            
                            LazyVGrid(columns:[GridItem(.flexible()), GridItem(.flexible())],spacing: 16){
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
                            
                            //Category Distribution Section
                            VStack(alignment: .leading, spacing: 12){
                                Text("Quick Breakdown")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing:14){
                                        CategoryCard(
                                            title: "Immediate",
                                            count: members.countImmediate(),
                                            icon: "house.fill"
                                            )
                                                    
                                        CategoryCard(
                                            title: "Extended",
                                            count: members.countExtended(),
                                            icon: "globe"
                                            )
                                                    
                                        CategoryCard(
                                            title: "Favorites",
                                            count: members.countFavorites(),
                                            icon: "star.fill"
                                            )
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                            // Recently Added Area
                            VStack(alignment:.leading, spacing:12){
                                Text("Recently added")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                if members.isEmpty {
                                    Text("No family members added yet. Add a family member to get started")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth:.infinity, alignment: .center)
                                        .padding(.vertical, 20)
                                } else {
                                    VStack(spacing:0){
                                        // Display atmost 3 recently added members
                                        ForEach(members.prefix(3), id: \.self){ member in
                                            HStack{
                                                Circle()
                                                    .fill(Color("BrandBlue").opacity(0.2))
                                                    .frame(width: 40, height: 40)
                                                    .overlay(
                                                        Text(String(member.name?.prefix(1) ?? "?"))
                                                            .bold()
                                                            .foregroundColor(Color("BrandBlue"))
                                                    )
                                                Text(member.name ?? "Unkown Member")
                                                    .font(.body)
                                                    .fontWeight(.medium)
                                                
                                                Spacer()
                                                
                                                Image(systemName: "chevron.right")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                            .padding()
                                            
                                            if member != members.prefix(3).last {
                                                Divider().padding(.leading, 70)
                                            }
                                        }
                                    }
                                    .background(Color(.secondarySystemGroupedBackground))
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
}

#Preview {
    FamilyDashboardView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}

