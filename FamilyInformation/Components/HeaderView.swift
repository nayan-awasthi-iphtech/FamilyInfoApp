////
////  HomeHeaderView.swift
////  FamilyInformation
////
////  Created by iPHTech4 on 7/10/26.
////
//
//import SwiftUI
//
//struct HomeHeaderView: View {
//    let memberCount: Int
//    var onAddMemberTapped: () -> Void // Plus button tap handle karne ke liye closure callback
//    
//    var body: some View {
//        HStack(alignment: .center, spacing: 0) {
//            
//            // LEFT CORNER: Elevated Card View
//            HStack(spacing: 12) {
//                ZStack {
//                    Circle()
//                        .fill(Color.white.opacity(0.25))
//                        .frame(width: 42, height: 42)
//                    
//                    Image(systemName: "house.lodge.fill")
//                        .font(.subheadline)
//                        .foregroundColor(.white)
//                }
//                
//                VStack(alignment: .leading, spacing: 2) {
//                    Text("My Family")
//                        .font(.system(size: 18, weight: .bold, design: .rounded))
//                        .foregroundColor(.white)
//                    
//                    Text("❤️ \(memberCount) Members")
//                        .font(.caption)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white.opacity(0.85))
//                }
//            }
//            .padding(.vertical, 10)
//            .padding(.horizontal, 14)
//            .background(
//                RoundedRectangle(cornerRadius: 16)
//                    .fill(Color("BrandBlue"))
//            )
//            .shadow(
//                color: Color("BrandBlue").opacity(0.3),
//                radius: 8,
//                x: 0,
//                y: 4
//            )
//            
//            Spacer() // Center Space
//            
//            // RIGHT CORNER: Plus Button
//            Button(action: onAddMemberTapped) {
//                ZStack {
//                    Circle()
//                        .fill(Color("BrandBlue"))
//                        .frame(width: 48, height: 48)
//                        .shadow(color: Color("BrandBlue").opacity(0.25), radius: 6, x: 0, y: 3)
//                    
//                    Image(systemName: "plus")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                }
//            }
//        }
//        .padding(.horizontal)
//        .padding(.top, 10)
//    }
//}
//
//#Preview {
//    HomeHeaderView(memberCount: 5, onAddMemberTapped: {})
//        .background(Color.gray.opacity(0.1))
//}
//


import SwiftUI

struct HomeHeaderView: View {
    let memberCount: Int
    var onAddMemberTapped: () -> Void
    
    // Globally injected theme listener
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            // LEFT CORNER: Elevated Card View
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(appState.isDarkMode ? 0.25 : 0.12))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "house.fill")
                        .font(.system(size: 16))
                        .foregroundColor(appState.isDarkMode ? .cyan : Color("BrandBlue"))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("My Family")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(appState.isDarkMode ? .white : .primary)
                    
                    Text("❤️ \(memberCount) Members")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(appState.isDarkMode ? .white.opacity(0.7) : .secondary)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 14)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(appState.isDarkMode ? Color(red: 0.2, green: 0.24, blue: 0.28) : Color.white)
                    .shadow(color: Color.white.opacity(appState.isDarkMode ? 0.2 : 0.04), radius: 6, x: 0, y: 3)
            )
            
            Spacer() // Center Space
            
            // MIDDLE: Theme Toggle Button (Sun / Moon)
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    appState.isDarkMode.toggle()
                }
            }) {
                ZStack {
                    Circle()
                        .fill(appState.isDarkMode ? Color(red: 0.22, green: 0.24, blue: 0.28) : Color.white)
                        .frame(width: 44, height: 44)
                        .shadow(color: Color.black.opacity(appState.isDarkMode ? 0.2 : 0.04), radius: 6, x: 0, y: 3)
                    
                    Image(systemName: appState.isDarkMode ? "moon.stars.fill" : "sun.max.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(appState.isDarkMode ? .purple : .orange)
                        .rotationEffect(.degrees(appState.isDarkMode ? 360 : 0))
                }
            }
            .shadow(
                color: appState.isDarkMode ? Color.white.opacity(0.4) : Color.black.opacity(0.04),
                radius: appState.isDarkMode ? 5 : 3,
                x: 0,
                y: appState.isDarkMode ? 2 : 1
            )
            .padding(.trailing, 12)
            
            // RIGHT CORNER: Plus Button (FULLY UPDATED)
            Button(action: onAddMemberTapped) {
                ZStack {
                    Circle()
                        // Dark mode mein vibrant glow ke liye cyan use karega, light mode mein standard BrandBlue
                        .fill(appState.isDarkMode ? Color.cyan : Color("BrandBlue"))
                        .frame(width: 44, height: 44)
                        .shadow(
                            color: appState.isDarkMode ? Color.cyan.opacity(0.2) : Color("BrandBlue").opacity(0.3),
                            radius: appState.isDarkMode ? 8 : 6,
                            x: 0,
                            y: 3
                        )
                    
                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .semibold))
                        // Text/Icon color updates dynamically for dark mode readability
                        .foregroundColor(appState.isDarkMode ? .black : .white)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    HomeHeaderView(memberCount: 5, onAddMemberTapped: {})
        .environmentObject(AppState.shared)
        .background(Color(.systemGroupedBackground))
}
