//
//  MemberInfoListView.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 10/07/26.
//

import SwiftUI

struct MemberInfoListView: View {
    @ObservedObject var member: Member
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    } ()

    var body: some View {
        VStack(spacing: 18) {
            MemberInfoCard(
                icon: "calendar",
                title: "Birthday",
                value: member.birthday != nil ? formatter.string(from: member.birthday!) : "Not Provided"
            )

            MemberInfoCard(
                icon: "person.fill",
                title: "Age",
                value: "\(member.age) Years"
            )

            MemberInfoCard(
                icon: "briefcase.fill",
                title: "Occupation",
                value: member.occupation ?? "None"
            )

            MemberInfoCard(
                icon: "phone.fill",
                title: "Phone",
                value: member.phone ?? "None"
            )

            MemberInfoCard(
                icon: "location.fill",
                title: "Address",
                value: member.address ?? "None"
            )
        }
    }
}
