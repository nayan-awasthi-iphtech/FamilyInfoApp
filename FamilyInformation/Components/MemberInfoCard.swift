////
////  MemberInfoCard.swift
////  FamilyInformation
////
////  Created by iPHTech4 on 7/8/26.
////
//
//import SwiftUI
//
//struct MemberInfoCard: View {
//    let icon: String
//    let title: String
//    let value: String
//    
//    var body: some View {
//
//        HStack(spacing: 18) {
//
//            ZStack {
//
//                Circle()
//                    .fill(
//                        LinearGradient(
//                            gradient: Gradient(colors: [
//                                Color("BrandBlue").opacity(0.15),
//                                Color.blue.opacity(0.05)
//                            ]),
//                            startPoint: .topLeading,
//                            endPoint: .bottomTrailing
//                        )
//                    )
//                    .frame(width: 55, height: 55)
//
//                Image(systemName: icon)
//                    .font(.title3)
//                    .foregroundColor(Color("BrandBlue"))
//            }
//
//            VStack(alignment: .leading, spacing: 6) {
//
//                Text(title.uppercased())
//                    .font(.caption)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.gray)
//
//                Text(value)
//                    .font(.headline)
//                    .foregroundColor(.primary)
//                    .lineLimit(nil)
//            }
//
//            Spacer()
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(18)
//        .shadow(
//            color: Color.black.opacity(0.06),
//            radius: 8,
//            x: 0,
//            y: 4
//        )
//    }
//}
//
//struct MemberInfoCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberInfoCard(icon: "phone.fill", title: "Phone", value: "45456465")
//    }
//}

import SwiftUI

struct MemberInfoCard: View {
    let icon: String
    let title: String
    let value: String
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(appState.isDarkMode ? Color.cyan.opacity(0.15) : Color.blue.opacity(0.08))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(appState.isDarkMode ? .cyan : Color("BrandBlue"))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(appState.isDarkMode ? .white.opacity(0.5) : .secondary)
                
                Text(value)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(appState.isDarkMode ? .white : .primary)
            }
            
            Spacer()
        }
        .padding(14)
        // Fix: Slate adaptive layout transformation matrix
        .background(appState.isDarkMode ? Color(red: 0.22, green: 0.24, blue: 0.28) : Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(appState.isDarkMode ? 0.12 : 0.02), radius: 6, x: 0, y: 3)
    }
}
