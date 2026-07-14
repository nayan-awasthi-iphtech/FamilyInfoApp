//
//  DashboardQuickBreakdownSection.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 14/07/26.
//

import SwiftUI

struct DashboardQuickBreakdownSection: View {
    var members: FetchedResults<Member>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Breakdown")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
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
    }
}
