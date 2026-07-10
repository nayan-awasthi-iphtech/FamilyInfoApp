//
//  MemberRowView.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/10/26.
//

import SwiftUI

struct MemberRowView: View {
    // Crucial for instant data stream binding updates when editing images
    @ObservedObject var member: Member

    var body: some View {
        HStack(spacing: 18) {

            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color("BrandBlue").opacity(0.15),
                                Color.blue.opacity(0.05)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 70, height: 70)

                // FIXED: Check if valid binary data exists, otherwise fallback to an SF Symbol icon
                if let imageData = member.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill() // Ensures custom user photos don't stretch
                        .frame(width: 70, height: 70) // Match the circle bounds
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundColor(Color("BrandBlue"))
                }
            }

            VStack(alignment: .leading, spacing: 6) {

                Text(member.name ?? "Unknown Name")
                    .font(.headline)
                    .foregroundColor(.primary)

                HStack(spacing: 6) {
                    Image(systemName: "person.2.fill")
                        .font(.caption)
                        .foregroundColor(Color("BrandBlue"))

                    Text(member.relationship ?? "Unknown Relationship")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 6) {
                    Image(systemName: "briefcase.fill")
                        .font(.caption)
                        .foregroundColor(.orange)

                    Text(member.occupation ?? "Unknown Occupation")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundColor(Color.gray.opacity(0.7))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(
            color: Color.black.opacity(0.08),
            radius: 8,
            x: 0,
            y: 4
        )
        .padding(.horizontal)
    }
}

// Updated modern swift preview syntax matching your context pipeline
#Preview {
    let context = PersistenceController.shared.container.viewContext
    let sampleMember = Member(context: context)
    sampleMember.name = "Rahul Sharma"
    sampleMember.relationship = "Brother"
    sampleMember.occupation = "Engineer"
    
    return MemberRowView(member: sampleMember)
}
