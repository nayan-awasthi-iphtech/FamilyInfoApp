//
//  FormStylesAndShared.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 14/07/26.
//

import SwiftUI

// Shared Icon
struct CustomFormIcon: View {
    let name: String
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Image(systemName: name)
            .foregroundColor(appState.isDarkMode ? .cyan : Color("BrandBlue"))
            .font(.system(size: 16, weight: .medium))
            .frame(width: 24, alignment: .center)
    }
}

// Shared Styling Modifiers
struct FormFieldStyleModifier: ViewModifier {
    let appState: AppState

    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(appState.isDarkMode ? Color(red: 0.28, green: 0.30, blue: 0.34) : Color(.systemGray6).opacity(0.6))
            .cornerRadius(10)
            .shadow(
                color: Color.black.opacity(appState.isDarkMode ? 0.0 : 0.03),
                radius: 2,
                x: 0,
                y: 1
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(appState.isDarkMode ? Color.clear : Color.black.opacity(0.03), lineWidth: 1)
            )
    }
}

extension View {
    func formFieldStyle(appState: AppState) -> some View {
        self.modifier(FormFieldStyleModifier(appState: appState))
    }
}
