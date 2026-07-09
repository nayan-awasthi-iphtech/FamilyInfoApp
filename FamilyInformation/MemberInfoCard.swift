//
//  MemberInfoCard.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/8/26.
//

import SwiftUI

struct MemberInfoCard: View {
    let icon: String
    let tilte: String
    let value: String
    
    var body: some View {

        HStack(spacing: 18) {

            ZStack {

                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color("BrandBlue").opacity(0.15),
                                Color.blue.opacity(0.05)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 55, height: 55)

                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(Color("BrandBlue"))
            }

            VStack(alignment: .leading, spacing: 6) {

                Text(tilte.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)

                Text(value)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(nil)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(
            color: Color.black.opacity(0.06),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

struct MemberInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        MemberInfoCard(icon: "phone.fill", tilte: "Phone", value: "45456465")
    }
}
