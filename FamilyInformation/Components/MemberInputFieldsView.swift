//
//  MemberInputFieldsView.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/10/26.
//

import SwiftUI

struct MemberInputFieldsView: View {
    @Binding var name: String
    @Binding var ageInput: String
    @Binding var relationship: String
    @Binding var phone: String
    @Binding var address: String
    @Binding var birthday: Date
    @Binding var occupation: String

    var body: some View {
        Group {
            Section(header: Text("PERSONAL INFORMATION").font(.caption).foregroundColor(Color("BrandBlue"))) {
                HStack {
                    Image(systemName: "person.fill").foregroundColor(Color("BrandBlue"))
                    TextField("Name", text: $name)
                }

                HStack {
                    Image(systemName: "calendar").foregroundColor(Color("BrandBlue"))
                    TextField("Age", text: $ageInput)
                        .keyboardType(.numberPad)
                }

                HStack {
                    Image(systemName: "person.2.fill").foregroundColor(Color("BrandBlue"))
                    TextField("Relationship", text: $relationship)
                }
            }

            Section(header: Text("CONTACT").font(.caption).foregroundColor(Color("BrandBlue"))) {
                HStack {
                    Image(systemName: "phone.fill").foregroundColor(Color("BrandBlue"))
                    TextField("Contact", text: $phone)
                }

                HStack {
                    Image(systemName: "location.fill").foregroundColor(Color("BrandBlue"))
                    TextField("Address", text: $address)
                }
            }

            Section(header: Text("PROFESSIONAL").font(.caption).foregroundColor(Color("BrandBlue"))) {
                HStack {
                    Image(systemName: "briefcase.fill").foregroundColor(Color("BrandBlue"))
                    TextField("Occupation", text: $occupation)
                }
            }

            Section(header: Text("BIRTHDAY").font(.caption).foregroundColor(Color("BrandBlue"))) {
                HStack {
                    Image(systemName: "gift.fill").foregroundColor(Color("BrandBlue"))
                    DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                }
            }
        }
    }
}
