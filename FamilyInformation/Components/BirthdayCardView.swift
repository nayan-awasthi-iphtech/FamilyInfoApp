//
//  BirthdayCardView.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/10/26.
//

import SwiftUI
import CoreData

struct BirthdayCardView: View {

    let birthdayMembers: [Member]

    var body: some View {
        if birthdayMembers.isEmpty {
            VStack(spacing: 15) {
                Image(systemName: "gift.fill")
                    .font(.system(size: 35))
                    .foregroundColor(Color("Birthday"))

                Text("Today's Birthday")
                    .font(.headline)

                Text("No birthdays today")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Your next celebration is coming soon 🎉")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 25)
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
            .padding(.horizontal)

        } else {
            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    Image(systemName: "gift.fill")
                        .font(.title2)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Today's Birthday")
                            .font(.headline)

                        Text("Celebrate your loved ones")
                            .font(.caption)
                            .opacity(0.9)
                    }

                    Spacer()
                }
                .foregroundColor(.white)

                ForEach(birthdayMembers) { member in
                    // Instantly sync image view redrawing when edited
                    BirthdayMemberRow(member: member)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("Birthday"),
                        Color("BrandBlue")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(
                color: Color("BrandBlue").opacity(0.25),
                radius: 10,
                x: 0,
                y: 6
            )
            .padding(.horizontal)
        }
    }
}

// Extracted Subview to perfectly catch individual member data edits live
struct BirthdayMemberRow: View {
    @ObservedObject var member: Member // Crucial for instant data stream binding updates

    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 60, height: 60)

                if let imageData = member.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(member.name ?? "Unknown")
                    .font(.headline)
                    .foregroundColor(.white)

                Text("🎉 Happy Birthday!")
                    .font(.subheadline)
                    .foregroundColor(Color.white.opacity(0.95))

                Text("Have a wonderful year ahead!")
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.85))
            }

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.12))
        .cornerRadius(15)
    }
}

// Updated modern swift preview syntax matching your context pipeline
#Preview {
    let context = PersistenceController.shared.container.viewContext
    let sampleMember = Member(context: context)
    sampleMember.name = "Rahul"
    
    return BirthdayCardView(birthdayMembers: [sampleMember])
        .environment(\.managedObjectContext, context)
}
