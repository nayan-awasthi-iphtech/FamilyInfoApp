//
//  MemberHeaderCardView.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 10/07/26.
//


import SwiftUI

struct MemberHeaderCardView: View {
    @ObservedObject var member: Member // Live monitoring updates during edits
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.75)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 250)
            .cornerRadius(25)
            .shadow(color: Color.blue.opacity(0.3), radius: 10)

            VStack(spacing: 15) {
                // Circular Profile Image
                Group {
                    if let imageData = member.image, imageData.count > 0, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .padding(22)
                    }
                }
                .frame(width: 134, height: 134)
                .background(Color.white)
                .clipShape(Circle())

                // Member Name
                Text(member.name ?? "Unknown Name")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                // Relationship Badge
                Text(member.relationship ?? "Family")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.25))
                    .clipShape(Capsule())
            }
        }
    }
}
