//
//  SaveMemberButton.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/10/26.
//

import SwiftUI

struct SaveMemberButton: View {
    var onSaveTapped: () -> Void

    var body: some View {
        Button(action: onSaveTapped) {
            HStack {
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                Text("Save Member").fontWeight(.semibold)
                Spacer()
            }
            .padding()
            .background(Color("BrandBlue"))
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
