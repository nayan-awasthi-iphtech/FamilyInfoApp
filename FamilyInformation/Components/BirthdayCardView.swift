////
////  BirthdayCardView.swift
////  FamilyInformation
////
////  Created by iPHTech4 on 7/10/26.
////
//
//import SwiftUI
//import CoreData
//
//struct BirthdayCardView: View {
//
//    let birthdayMembers: [Member]
//
//    var body: some View {
//        if birthdayMembers.isEmpty {
//            VStack(spacing: 15) {
//                Image(systemName: "gift.fill")
//                    .font(.system(size: 35))
//                    .foregroundColor(Color("Birthday"))
//
//                Text("Today's Birthday")
//                    .font(.headline)
//
//                Text("No birthdays today")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//
//                Text("Your next celebration is coming soon 🎉")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//            .frame(maxWidth: .infinity)
//            .padding(.vertical, 25)
//            .background(Color.white)
//            .cornerRadius(18)
//            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
//            .padding(.horizontal)
//
//        } else {
//            VStack(alignment: .leading, spacing: 18) {
//                HStack {
//                    Image(systemName: "gift.fill")
//                        .font(.title2)
//
//                    VStack(alignment: .leading, spacing: 2) {
//                        Text("Today's Birthday")
//                            .font(.headline)
//
//                        Text("Celebrate your loved ones")
//                            .font(.caption)
//                            .opacity(0.9)
//                    }
//
//                    Spacer()
//                }
//                .foregroundColor(.white)
//
//                ForEach(birthdayMembers) { member in
//                    // Instantly sync image view redrawing when edited
//                    BirthdayMemberRow(member: member)
//                }
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding()
//            .background(
//                LinearGradient(
//                    gradient: Gradient(colors: [
//                        Color("Birthday"),
//                        Color("BrandBlue")
//                    ]),
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
//            )
//            .cornerRadius(20)
//            .shadow(
//                color: Color("BrandBlue").opacity(0.25),
//                radius: 10,
//                x: 0,
//                y: 6
//            )
//            .padding(.horizontal)
//        }
//    }
//}
//
//// Extracted Subview to perfectly catch individual member data edits live
//struct BirthdayMemberRow: View {
//    @ObservedObject var member: Member // Crucial for instant data stream binding updates
//
//    var body: some View {
//        HStack(spacing: 15) {
//            ZStack {
//                Circle()
//                    .fill(Color.white.opacity(0.2))
//                    .frame(width: 60, height: 60)
//
//                if let imageData = member.image, let uiImage = UIImage(data: imageData) {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 60, height: 60)
//                        .clipShape(Circle())
//                } else {
//                    Image(systemName: "person.circle.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.white)
//                }
//            }
//
//            VStack(alignment: .leading, spacing: 5) {
//                Text(member.name ?? "Unknown")
//                    .font(.headline)
//                    .foregroundColor(.white)
//
//                Text("🎉 Happy Birthday!")
//                    .font(.subheadline)
//                    .foregroundColor(Color.white.opacity(0.95))
//
//                Text("Have a wonderful year ahead!")
//                    .font(.caption)
//                    .foregroundColor(Color.white.opacity(0.85))
//            }
//
//            Spacer()
//        }
//        .padding()
//        .background(Color.white.opacity(0.12))
//        .cornerRadius(15)
//    }
//}
//
//// Updated modern swift preview syntax matching your context pipeline
//#Preview {
//    let context = PersistenceController.shared.container.viewContext
//    let sampleMember = Member(context: context)
//    sampleMember.name = "Rahul"
//    
//    return BirthdayCardView(birthdayMembers: [sampleMember])
//        .environment(\.managedObjectContext, context)
//}


import SwiftUI
import CoreData

struct BirthdayCardView: View {
    let birthdayMembers: [Member]
    
    // Globally injected theme listener
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if !birthdayMembers.isEmpty {
            // Figma-style dynamic coral-orange mesh card when birthdays exist
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 6) {
                    Image(systemName: "birthday.cake.fill")
                        .font(.system(size: 16))
                    Text("Birthdays Today!")
                        .font(.system(size: 16, weight: .bold))
                }
                .foregroundColor(.white)
                
                HStack(spacing: 16) {
                    ForEach(birthdayMembers.prefix(3)) { member in
                        // FIX: Passing into ObservedObject subview to trigger instant image updates! 🔄
                        BirthdayAvatarView(member: member)
                    }
                }
                
                let namesText = birthdayMembers.map { "\($0.name ?? "Someone") turns \($0.age) today 🎂" }.joined(separator: " • ")
                Text(namesText)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.top, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(18)
            .background(
                LinearGradient(
                    // Dark mode mein subtle neon spectrum aur light mode mein standard vibrant pink-orange
                    colors: appState.isDarkMode ? [
                        Color.pink.opacity(0.7),
                        Color.purple.opacity(0.7)
                    ] : [
                        Color.pink.opacity(0.85),
                        Color.orange.opacity(0.85)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(
                color: appState.isDarkMode ? Color.pink.opacity(0.3) : Color.orange.opacity(0.2),
                radius: 8,
                x: 0,
                y: 4
            )
            .padding(.horizontal, 20)
            
        } else {
            // Clean, elegant placeholder card matching the light/dark UI themes when empty
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        // Icon circle shifts beautifully to darker neon blue in dark mode
                        .fill(appState.isDarkMode ? Color.blue.opacity(0.25) : Color.blue.opacity(0.08))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: "gift")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(appState.isDarkMode ? .cyan : Color("BrandBlue").opacity(0.8))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("No Birthdays Today")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(appState.isDarkMode ? .white : .primary)
                    
                    Text("Your next family celebration will show up here.")
                        .font(.system(size: 12))
                        .foregroundColor(appState.isDarkMode ? .white.opacity(0.8) : .secondary)
                }
                
                Spacer()
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            // Fix: Elevates the empty card background color dynamically
            .background(appState.isDarkMode ? Color(red: 0.25, green: 0.26, blue: 0.29) : Color.white)
            .cornerRadius(16)
            .shadow(color: Color.white.opacity(appState.isDarkMode ? 0.2 : 0.02), radius: 6, x: 1, y: 3)
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Extracted Subview (Keeps original avatar UI, fixes image update logic)
struct BirthdayAvatarView: View {
    @ObservedObject var member: Member // Crucial link: forces the avatar layout to reload on database saves!
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 50, height: 50)
                
                if let imageData = member.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    Text(String(member.name?.prefix(2) ?? "??").uppercased())
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            
            Text(member.name ?? "Unknown")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    return VStack(spacing: 20) {
        BirthdayCardView(birthdayMembers: []) // Empty state check
            .environmentObject(AppState.shared)
    }
    .background(Color(.systemGroupedBackground))
}
