////
////  SaveMemberButton.swift
////  FamilyInformation
////
////  Created by iPHTech4 on 7/10/26.
////
//
//import SwiftUI
//
//struct SaveMemberButton: View {
//    var onSaveTapped: () -> Void
//
//    var body: some View {
//        Button(action: onSaveTapped) {
//            HStack {
//                Spacer()
//                Image(systemName: "checkmark.circle.fill")
//                Text("Save Member").fontWeight(.semibold)
//                Spacer()
//            }
//            .padding()
//            .background(Color("BrandBlue"))
//            .foregroundColor(.white)
//            .cornerRadius(12)
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}


import SwiftUI

struct SaveMemberButton: View {
    var onSaveTapped: () -> Void
    
    // Globally injected theme listener
    @EnvironmentObject var appState: AppState

    var body: some View {
        Button(action: onSaveTapped) {
            HStack(spacing: 8) {
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16, weight: .bold))
                
                Text("Save Member")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                Spacer()
            }
            .padding(.vertical, 14)
            // Fix: Dynamic premium mesh gradient for modern dark/light styling
            .background(
                LinearGradient(
                    colors: appState.isDarkMode ? [
                        Color.cyan,
                        Color.blue
                    ] : [
                        Color("BrandBlue"),
                        Color("BrandBlue").opacity(0.85)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            // Fix: Text elements are black over high-contrast cyan in dark mode for better accessibility
            .foregroundColor(appState.isDarkMode ? .black : .white)
            .cornerRadius(14)
            // Fix: Deep premium atmospheric shadow mapping
            .shadow(
                color: appState.isDarkMode ? Color.cyan.opacity(0.3) : Color("BrandBlue").opacity(0.2),
                radius: 8,
                x: 0,
                y: 4
            )
            .padding(.horizontal, 20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
