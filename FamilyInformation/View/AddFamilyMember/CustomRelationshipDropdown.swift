//
//  CustomRelationshipDropdown.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 14/07/26.
//

import SwiftUI

struct CustomRelationshipDropdown: View {
    @Binding var relationship: String
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack(spacing: 12) {
            CustomFormIcon(name: "person.2.fill")
            
            Menu {
                ForEach(RelationshipType.allCases) { type in
                    Button(type.displayName) {
                        relationship = type.rawValue
                    }
                }
            } label: {
                HStack {
                    Text(relationship.isEmpty ? "Select Relationship" : relationship)
                        .font(.system(size: 15))
                        .foregroundColor(relationship.isEmpty ? (appState.isDarkMode ? .white.opacity(0.35) : .gray.opacity(0.6)) : (appState.isDarkMode ? .white : .primary))
                        
                    Spacer()
                    
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.gray.opacity(0.8))
                }
            }
        }
        .formFieldStyle(appState: appState)
    }
}
