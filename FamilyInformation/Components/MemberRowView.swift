//
//  MemberRowView.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/8/26.
//

import SwiftUI

struct MemberRowView: View {
    let member: Member

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
                    .frame(width: 70, height: 70)

                Image(systemName: member.image ?? "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .foregroundColor(Color("BrandBlue"))
            }

            VStack(alignment: .leading, spacing: 6) {

                Text(member.name ?? "unknown Name")
                    .font(.headline)
                    .foregroundColor(.primary)

                HStack(spacing: 6) {

                    Image(systemName: "person.2.fill")
                        .font(.caption)
                        .foregroundColor(Color("BrandBlue"))

                    Text(member.relationship ?? "unkown relationship")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 6) {

                    Image(systemName: "briefcase.fill")
                        .font(.caption)
                        .foregroundColor(.orange)

                    Text(member.occupation ?? "unkown occupation")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundColor(Color.gray.opacity(0.7))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(
            color: Color.black.opacity(0.08),
            radius: 8,
            x: 0,
            y: 4
        )
        .padding(.horizontal)
    }
}

struct MemberRowView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let blankMember = Member(context: context)

        return MemberRowView(member: blankMember)
            .previewLayout(.sizeThatFits)
    }
}

