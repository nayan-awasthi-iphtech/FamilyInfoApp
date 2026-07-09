import SwiftUI
import CoreData

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

    var body: some View {
        Form {
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

                    // FIXED: Create a new Core Data object directly inside viewContext
                    let newMember = Member(context: viewContext)
                    newMember.name = name
                    newMember.age = age
                    newMember.relationship = relationship
                    newMember.phone = phone
                    newMember.address = address.isEmpty ? "None" : address
                    newMember.occupation = occupation.isEmpty ? "None" : occupation
                    newMember.birthday = birthday
                    newMember.image = "person.circle.fill"

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
        .alert(isPresented: $isAlert) {
            Alert(
                title: Text("Missing Information"),
                message: Text("Please make sure Name, Age, Relationship, and Contact fields are filled out correctly."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// FIXED: Cleaned preview to load temporary in-memory environment context
struct AddFamilyMember_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        return NavigationView {
            AddFamilyMember()
                .environment(\.managedObjectContext, context)
        }
    }
}

