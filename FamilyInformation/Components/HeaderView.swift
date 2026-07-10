//
//  HomeHeaderView.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/10/26.
//

import SwiftUI

struct HomeHeaderView: View {
    let memberCount: Int
    var onAddMemberTapped: () -> Void // Plus button tap handle karne ke liye closure callback
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            // LEFT CORNER: Elevated Card View
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.25))
                        .frame(width: 42, height: 42)
                    
                    Image(systemName: "house.lodge.fill")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("My Family")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("❤️ \(memberCount) Members")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.85))
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("BrandBlue"))
            )
            .shadow(
                color: Color("BrandBlue").opacity(0.3),
                radius: 8,
                x: 0,
                y: 4
            )
            
            Spacer() // Center Space
            
            // RIGHT CORNER: Plus Button
            Button(action: onAddMemberTapped) {
                ZStack {
                    Circle()
                        .fill(Color("BrandBlue"))
                        .frame(width: 48, height: 48)
                        .shadow(color: Color("BrandBlue").opacity(0.25), radius: 6, x: 0, y: 3)
                    
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
    HomeHeaderView(memberCount: 5, onAddMemberTapped: {})
        .background(Color.gray.opacity(0.1))
}
