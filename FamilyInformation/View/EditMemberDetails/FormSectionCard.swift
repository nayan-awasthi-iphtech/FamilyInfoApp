////
////  FormSectionCard.swift
////  FamilyInformation
////
////  Created by iPHTech 30 on 13/07/26.
////
//
//import SwiftUI
//
//struct FormSectionCard<Content: View>: View {
//    let title: String
//    let content: Content
//    
//    init(title: String, @ViewBuilder content: () -> Content) {
//        self.title = title
//        self.content = content()
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text(title)
//                .font(.headline)
//            content
//        }
//        .padding(12)
//        .background(Color.white.opacity(0.8))
//        .cornerRadius(16)
//        .shadow(color: Color.black.opacity(0.05), radius: 6)
//        .padding(.horizontal)
//    }
//}


import SwiftUI

struct FormSectionCard<Content: View>: View {
    let title: String
    let content: Content
    
    @EnvironmentObject var appState: AppState
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                // Fix: Card sectional header color settings
                .foregroundColor(appState.isDarkMode ? .white.opacity(0.6) : .secondary)
                .padding(.leading, 4)
            
            content
        }
        .padding(12)
        // Fix: Premium card layer layout transformation structure matrix
        .background(appState.isDarkMode ? Color(red: 0.22, green: 0.24, blue: 0.28).opacity(0.7) : Color.white.opacity(0.8))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(appState.isDarkMode ? 0.15 : 0.04), radius: 6, x: 0, y: 3)
        .padding(.horizontal)
    }
}
