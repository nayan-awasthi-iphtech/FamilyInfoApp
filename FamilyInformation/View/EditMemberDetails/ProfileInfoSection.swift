//
//  ProfileInfoSection.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 13/07/26.
//

import SwiftUI

struct PersonalInfoSection: View {
    @ObservedObject var member: Member
    
    var body: some View {
        FormSectionCard(title: "Personal Information") {
            TextField("Name", text: Binding(
                get: { member.name ?? "" },
                set: { member.name = $0 }
            ))
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)

            TextField("Age", text: Binding(
                get: { String(member.age) },
                set: { member.age = Int16($0) ?? 0 }
            ))
            .keyboardType(.numberPad)
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)

            TextField("Relationship", text: Binding(
                get: { member.relationship ?? "" },
                set: { member.relationship = $0 }
            ))
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

struct ContactInfoSection: View {
    @ObservedObject var member: Member
    
    var body: some View {
        FormSectionCard(title: "Contact") {
            TextField("Phone", text: Binding(
                get: { member.phone ?? "" },
                set: { member.phone = $0 }
            ))
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)

            TextField("Address", text: Binding(
                get: { member.address ?? "" },
                set: { member.address = $0 }
            ))
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

struct ProfessionalInfoSection: View {
    @ObservedObject var member: Member
    
    var body: some View {
        FormSectionCard(title: "Professional") {
            TextField("Occupation", text: Binding(
                get: { member.occupation ?? "" },
                set: { member.occupation = $0 }
            ))
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

struct BirthdayInfoSection: View {
    @ObservedObject var member: Member
    
    var body: some View {
        FormSectionCard(title: "Birthday") {
            DatePicker(
                "Birthday",
                selection: Binding(
                    get: { member.birthday ?? Date() },
                    set: { member.birthday = $0 }
                ),
                displayedComponents: .date
            )
        }
    }
}
