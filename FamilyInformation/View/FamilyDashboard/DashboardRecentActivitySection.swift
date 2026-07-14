//
//  DashboardRecentActivitySection.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 14/07/26.
//

import SwiftUI

struct DashboardRecentActivitySection: View {
    var members: [Member]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recently added")
                .font(.headline)
                .padding(.horizontal)
            
            if members.isEmpty {
                Text("No family members added yet. Add a family member to get started")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 20)
            } else {
                VStack(spacing: 0) {
                    ForEach(members, id: \.self) { member in
                        HStack(spacing: 14) {
                            Circle()
                                .fill(Color("BrandBlue").opacity(0.2))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Text(String(member.name?.prefix(1) ?? "?"))
                                        .bold()
                                        .foregroundColor(Color("BrandBlue"))
                                )
                            
                            Text(member.name ?? "Unknown Member")
                                .font(.body)
                                .fontWeight(.medium)
                            
                            Spacer()
                            if member.isFavorite {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.orange)
                            }
                        }
                        .padding()
                        
                        if member != members.last {
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
}   
