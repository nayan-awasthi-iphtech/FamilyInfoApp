////
////  MemberInputFieldsView.swift
////  FamilyInformation
////
////  Created by iPHTech4 on 7/10/26.
////
//
//import SwiftUI
//
//struct MemberInputFieldsView: View {
//    @Binding var name: String
//    @Binding var ageInput: String
//    @Binding var relationship: String
//    @Binding var phone: String
//    @Binding var address: String
//    @Binding var birthday: Date
//    @Binding var occupation: String
//
//    var body: some View {
//        Group {
//            Section(header: Text("PERSONAL INFORMATION").font(.caption).foregroundColor(Color("BrandBlue"))) {
//                HStack {
//                    Image(systemName: "person.fill").foregroundColor(Color("BrandBlue"))
//                    TextField("Name", text: $name)
//                }
//
//                HStack {
//                    Image(systemName: "calendar").foregroundColor(Color("BrandBlue"))
//                    TextField("Age", text: $ageInput)
//                        .keyboardType(.numberPad)
//                }
//
//                HStack {
//                    Image(systemName: "person.2.fill").foregroundColor(Color("BrandBlue"))
//                    TextField("Relationship", text: $relationship)
//                }
//            }
//
//            Section(header: Text("CONTACT").font(.caption).foregroundColor(Color("BrandBlue"))) {
//                HStack {
//                    Image(systemName: "phone.fill").foregroundColor(Color("BrandBlue"))
//                    TextField("Contact", text: $phone)
//                }
//
//                HStack {
//                    Image(systemName: "location.fill").foregroundColor(Color("BrandBlue"))
//                    TextField("Address", text: $address)
//                }
//            }
//
//            Section(header: Text("PROFESSIONAL").font(.caption).foregroundColor(Color("BrandBlue"))) {
//                HStack {
//                    Image(systemName: "briefcase.fill").foregroundColor(Color("BrandBlue"))
//                    TextField("Occupation", text: $occupation)
//                }
//            }
//
//            Section(header: Text("BIRTHDAY").font(.caption).foregroundColor(Color("BrandBlue"))) {
//                HStack {
//                    Image(systemName: "gift.fill").foregroundColor(Color("BrandBlue"))
//                    DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
//                }
//            }
//        }
//    }
//}


import SwiftUI

struct MemberInputFieldsView: View {
    // Shared Two-Way Bindings connected straight to parent container screens
    @Binding var name: String
    @Binding var ageInput: String
    @Binding var relationship: String
    @Binding var phone: String
    @Binding var address: String
    @Binding var birthday: Date
    @Binding var occupation: String

    @EnvironmentObject var appState: AppState // Global theme listener injected

    var body: some View {
        VStack(spacing: 16) {
            
            // MARK: - Personal Information Section
            FormSectionCard(title: "PERSONAL INFORMATION") {
                VStack(spacing: 12) {
                    // Isolated External Custom Components Integration
                    CustomInputField(placeholder: "Name", text: $name, imageName: "person.fill")
                    CustomInputField(placeholder: "Age", text: $ageInput, imageName: "calendar", isNumberPad: true)
                    CustomRelationshipDropdown(relationship: $relationship)
                }
            }

            // MARK: - Contact Info Section
            FormSectionCard(title: "CONTACT") {
                VStack(spacing: 12) {
                    CustomInputField(placeholder: "Contact", text: $phone, imageName: "phone.fill", isNumberPad: true)
                    CustomInputField(placeholder: "Address", text: $address, imageName: "location.fill")
                }
            }

            // MARK: - Professional Info Section
            FormSectionCard(title: "PROFESSIONAL") {
                CustomInputField(placeholder: "Occupation", text: $occupation, imageName: "briefcase.fill")
            }

            // MARK: - Birthday Field Section
            FormSectionCard(title: "BIRTHDAY") {
                HStack(spacing: 12) {
                    CustomFormIcon(name: "gift.fill")
                    
                    DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(appState.isDarkMode ? .white : .primary)
                }
                .formFieldStyle(appState: appState) // Shared style dynamic layout hook
            }
        }
    }
}
