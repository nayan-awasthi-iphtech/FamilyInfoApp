//
//  AddFamilyMember.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/10/26.
//

import SwiftUI
import CoreData
import PhotosUI

struct AddFamilyMember: View {

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    // Input States
    @State private var name: String = ""
    @State private var ageInput: String = ""
    @State private var relationship: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var birthday: Date = Date()
    @State private var occupation: String = ""

    @State private var isAlert = false
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil

    var body: some View {
        Form {
            // 1. Photo Picker Component
            Section {
                ProfileImagePickerView(selectedItem: $selectedItem, selectedImage: $selectedImage)
            }
            .listRowBackground(Color.clear)
            
            // 2. Extracted Input Fields Component
            MemberInputFieldsView(
                name: $name,
                ageInput: $ageInput,
                relationship: $relationship,
                phone: $phone,
                address: $address,
                birthday: $birthday,
                occupation: $occupation
            )

            // 3. Extracted Save Button Component with validation action closure
            Section {
                SaveMemberButton {
                    validateAndSaveMember()
                }
            }

            Section {
                Text("All information can be edited later.")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Add Member")
        .alert("Missing Information", isPresented: $isAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please make sure Name, Age, Relationship, and Contact fields are filled out correctly.")
        }
    }

    // Isolated Core Data saving action handler
    private func validateAndSaveMember() {
        guard !name.isEmpty,
              let age = Int16(ageInput),
              age > 0,
              !relationship.isEmpty,
              !phone.isEmpty
        else {
            isAlert = true
            return
        }

        let newMember = Member(context: viewContext)
        
        // CRITICAL FIX: Har naye member ko ek unique ID dena compulsory hai!
        newMember.id = UUID()
        
        newMember.name = name
        newMember.age = age
        newMember.relationship = relationship
        newMember.phone = phone
        newMember.address = address.isEmpty ? "None" : address
        newMember.occupation = occupation.isEmpty ? "None" : occupation
        newMember.birthday = birthday
        
        if let uiImage = selectedImage {
            newMember.image = uiImage.jpegData(compressionQuality: 0.7)
        } else {
            newMember.image = nil
        }

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Failed to save new member: \(error.localizedDescription)")
        }
    }
}

#Preview {
    NavigationStack {
        AddFamilyMember()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
