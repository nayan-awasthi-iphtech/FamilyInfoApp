import SwiftUI
import CoreData
import UIKit

struct AddFamilyMember: View {

    // Core Data viewContext for saving new entities
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    // State variables for capturing form data individually
    @State private var name: String = ""
    @State private var ageInput: String = ""
    @State private var relationship: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var birthday: Date = Date()
    @State private var occupation: String = ""

    @State private var isAlert = false
    
    @State private var selectedImage: UIImage? = nil
    
    // Tracks when to present the image gallery overlay
    @State private var showImagePicker = false

    var body: some View {
        Form {
            Section {
                VStack(spacing: 12) {
                    
                    Button(action: {
                        showImagePicker = true
                    }) {
                        ZStack(alignment: .bottomTrailing) {
                            Group {
                                if let image = selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(30)
                                        .foregroundColor(.gray)
                                }
                            }
                            .frame(width: 120, height: 120)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color("BrandBlue"), lineWidth: 2)
                            )

                            Circle()
                                .fill(Color("BrandBlue"))
                                .frame(width: 38, height: 38)
                                .overlay(
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                )
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // Cleaned button highlight type

                    Text("Upload Photo")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
            }
            .listRowBackground(Color.clear)
            
            Section(
                header:
                    Text("PERSONAL INFORMATION")
                    .font(.caption)
                    .foregroundColor(Color("BrandBlue"))
            ) {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(Color("BrandBlue"))

                    TextField("Name", text: $name)
                }

                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(Color("BrandBlue"))

                    TextField("Age", text: $ageInput)
                        .keyboardType(.numberPad)
                }

                HStack {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(Color("BrandBlue"))

                    TextField("Relationship", text: $relationship)
                }
            }

            Section(
                header:
                    Text("CONTACT")
                    .font(.caption)
                    .foregroundColor(Color("BrandBlue"))
            ) {
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(Color("BrandBlue"))

                    TextField("Contact", text: $phone)
                }

                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(Color("BrandBlue"))

                    TextField("Address", text: $address)
                }
            }

            Section(
                header:
                    Text("PROFESSIONAL")
                    .font(.caption)
                    .foregroundColor(Color("BrandBlue"))
            ) {
                HStack {
                    Image(systemName: "briefcase.fill")
                        .foregroundColor(Color("BrandBlue"))

                    TextField("Occupation", text: $occupation)
                }
            }

            Section(
                header:
                    Text("BIRTHDAY")
                    .font(.caption)
                    .foregroundColor(Color("BrandBlue"))
            ) {
                HStack {
                    Image(systemName: "gift.fill")
                        .foregroundColor(Color("BrandBlue"))

                    DatePicker(
                        "Birthday",
                        selection: $birthday,
                        displayedComponents: .date
                    )
                }
            }

            Section {
                Button(action: {
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
                    newMember.name = name
                    newMember.age = age
                    newMember.relationship = relationship
                    newMember.phone = phone
                    newMember.address = address.isEmpty ? "None" : address
                    newMember.occupation = occupation.isEmpty ? "None" : occupation
                    newMember.birthday = birthday
                    
                    // Convert chosen UIImage to binary data format for Core Data saving
                    if let uiImage = selectedImage {
                        newMember.image = uiImage.jpegData(compressionQuality: 0.7)
                    } else {
                        newMember.image = nil
                    }

                    // Save changes to database
                    do {
                        try viewContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Failed to save new member: \(error.localizedDescription)")
                    }

                }) {
                    HStack {
                        Spacer()

                        Image(systemName: "checkmark.circle.fill")

                        Text("Save Member")
                            .fontWeight(.semibold)

                        Spacer()
                    }
                    .padding()
                    .background(Color("BrandBlue"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
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
        // Present image view sheet wrapper overlay layout
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .alert(isPresented: $isAlert) {
            Alert(
                title: Text("Missing Information"),
                message: Text("Please make sure Name, Age, Relationship, and Contact fields are filled out correctly."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct AddFamilyMember_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        return NavigationView {
            AddFamilyMember()
                .environment(\.managedObjectContext, context)
        }
    }
}
