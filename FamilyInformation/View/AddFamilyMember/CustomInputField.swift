//
//  CustomInputField.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 14/07/26.
//

import SwiftUI

struct CustomInputField: View {
    
    let placeholder: String
    @Binding var text: String
    let imageName:String
    var isNumberPad: Bool = false
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack(spacing: 12) {
            CustomFormIcon(name: imageName)
            
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(appState.isDarkMode ? .white.opacity(0.2) : .gray.opacity(0.6)))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.none)
                .keyboardType(isNumberPad ? .numberPad : .default)
                .font(.system(size: 15))
                .foregroundColor(appState.isDarkMode ? .white : .primary)
        }
        .formFieldStyle(appState: appState)
    }
}
