//
//  DashboardHeaderView.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 14/07/26.
//

import SwiftUI

struct DashboardHeaderView: View {
    @Binding var isSheetShowing: Bool
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Family Overview")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .foregroundColor(.primary)
                
                Text("Summary and stats of your family networks.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Button {
                isSheetShowing = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chart.bar.xaxis")
                    Text("View Analytics")
                }
                .font(.system(size: 14, weight: .bold))
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(appState.isDarkMode ? Color.cyan.opacity(0.15) : Color.blue.opacity(0.1))
                .foregroundColor(appState.isDarkMode ? .cyan : .blue)
                .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top, 16)
    }
}
