//    //
//    //  MemberRowView.swift
//    //  FamilyInformation
//    //
//    //  Created by iPHTech4 on 7/10/26.
//    //
//
//    import SwiftUI
//
//    struct MemberRowView: View {
//        // Crucial for instant data stream binding updates when editing images
//        @ObservedObject var member: Member
//
//        var body: some View {
//            HStack(spacing: 18) {
//
//                ZStack {
//                    Circle()
//                        .fill(
//                            LinearGradient(
//                                gradient: Gradient(colors: [
//                                    Color("BrandBlue").opacity(0.15),
//                                    Color.blue.opacity(0.05)
//                                ]),
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            )
//                        )
//                        .frame(width: 70, height: 70)
//
//                    // FIXED: Check if valid binary data exists, otherwise fallback to an SF Symbol icon
//                    if let imageData = member.image, let uiImage = UIImage(data: imageData) {
//                        Image(uiImage: uiImage)
//                            .resizable()
//                            .scaledToFill() // Ensures custom user photos don't stretch
//                            .frame(width: 70, height: 70) // Match the circle bounds
//                            .clipShape(Circle())
//                    } else {
//                        Image(systemName: "person.circle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 35, height: 35)
//                            .foregroundColor(Color("BrandBlue"))
//                    }
//                }
//
//                VStack(alignment: .leading, spacing: 6) {
//
//                    Text(member.name ?? "Unknown Name")
//                        .font(.headline)
//                        .foregroundColor(.primary)
//
//                    HStack(spacing: 6) {
//                        Image(systemName: "person.2.fill")
//                            .font(.caption)
//                            .foregroundColor(Color("BrandBlue"))
//
//                        Text(member.relationship ?? "Unknown Relationship")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//
//                    HStack(spacing: 6) {
//                        Image(systemName: "briefcase.fill")
//                            .font(.caption)
//                            .foregroundColor(.orange)
//
//                        Text(member.occupation ?? "Unknown Occupation")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                    }
//                }
//
//                Spacer()
//
//                Image(systemName: "chevron.right")
//                    .font(.headline)
//                    .foregroundColor(Color.gray.opacity(0.7))
//            }
//            .padding()
//            .background(Color.white)
//            .cornerRadius(18)
//            .shadow(
//                color: Color.black.opacity(0.08),
//                radius: 8,
//                x: 0,
//                y: 4
//            )
//            .padding(.horizontal)
//        }
//    }
//
//    // Updated modern swift preview syntax matching your context pipeline
//    #Preview {
//        let context = PersistenceController.shared.container.viewContext
//        let sampleMember = Member(context: context)
//        sampleMember.name = "Rahul Sharma"
//        sampleMember.relationship = "Brother"
//        sampleMember.occupation = "Engineer"
//        
//        return MemberRowView(member: sampleMember)
//    }




import SwiftUI

struct MemberRowView: View {
    @ObservedObject var member: Member
    
    // Globally injected theme listener
    @EnvironmentObject var appState: AppState
    
    // Colorful tags engine to match Figma design swatches dynamically
    private var randomSwatchColor: Color {
        // Dark mode mein zyada light/neon tints use karenge taaki visibility flawless rahe
        let colors: [Color] = appState.isDarkMode
            ? [.pink, .cyan, .purple, .teal, .green, .orange]
            : [.pink, .blue, .purple, .teal, .indigo, .orange]
        let index = abs((member.name ?? "").hashValue) % colors.count
        return colors[index]
    }
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(randomSwatchColor.opacity(appState.isDarkMode ? 0.25 : 0.18))
                    .frame(width: 52, height: 52)
                
                if let imageData = member.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 52, height: 52)
                        .clipShape(Circle())
                } else {
                    Text(String(member.name?.prefix(2) ?? "??").uppercased())
                        .font(.system(size: 15, weight: .bold))
                        // Dynamic text visibility fix for placeholder initials
                        .foregroundColor(appState.isDarkMode ? randomSwatchColor.opacity(0.9) : randomSwatchColor)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(member.name ?? "Unknown Name")
                    .font(.system(size: 15, weight: .bold))
                    // Fix: Dynamic foreground text switching
                    .foregroundColor(appState.isDarkMode ? .white : .primary)
                
                HStack(spacing: 6) {
                    Text(member.relationship ?? "Family")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(appState.isDarkMode ? randomSwatchColor.opacity(0.95) : randomSwatchColor)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .background(randomSwatchColor.opacity(appState.isDarkMode ? 0.25 : 0.12))
                        .clipShape(Capsule())
                    
                    Text("\(member.age) yrs")
                        .font(.system(size: 12))
                        // Fix: Secondary gray scaling for clean readability
                        .foregroundColor(appState.isDarkMode ? .white.opacity(0.6) : .secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                // Fix: Dynamic chevron opacity so it doesn't vanish in dark mode
                .foregroundColor(appState.isDarkMode ? .white.opacity(0.4) : .gray.opacity(0.4))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        // Fix: Slate elevated container background mesh mapping
        .background(appState.isDarkMode ? Color(red: 0.22, green: 0.24, blue: 0.28) : Color.white)
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(appState.isDarkMode ? 0.15 : 0.02), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 20)
    }
}
