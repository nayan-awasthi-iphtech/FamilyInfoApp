//
//  FormSectionCard.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 13/07/26.
//

import SwiftUI

struct FormSectionCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            content
        }
        .padding(12)
        .background(Color.white.opacity(0.8))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6)
        .padding(.horizontal)
    }
}
