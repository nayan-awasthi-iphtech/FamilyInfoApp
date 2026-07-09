import SwiftUI
import CoreData

struct EditMemberView: View {

    // FIXED: Core Data handles changes via ObservedObject, not a strict local @Binding struct array
    @ObservedObject var member: Member

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("BrandBlue").opacity(0.12),
                        Color.white
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 14) {

                        // 1. Personal Information
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Personal Information")
                                .font(.headline)

                            // FIXED: Clean optional string bindings using custom extensions/inline wrappers
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
                        .padding(12)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 6)
                        .padding(.horizontal)

                        // 2. Contact Information
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Contact")
                                .font(.headline)

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
                        .padding(12)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 6)
                        .padding(.horizontal)

                        // 3. Professional Information
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Professional")
                                .font(.headline)

                            TextField("Occupation", text: Binding(
                                get: { member.occupation ?? "" },
                                set: { member.occupation = $0 }
                            ))
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        .padding(12)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 6)
                        .padding(.horizontal)

                        // 4. Birthday Date picker
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Birthday")
                                .font(.headline)

                            DatePicker(
                                "Birthday",
                                selection: Binding(
                                    get: { member.birthday ?? Date() },
                                    set: { member.birthday = $0 }
                                ),
                                displayedComponents: .date
                            )
                        }
                        .padding(12)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 6)
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Edit Member")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    guard let name = member.name, !name.isEmpty,
                          member.age > 0,
                          let rel = member.relationship, !rel.isEmpty,
                          let phone = member.phone, !phone.isEmpty
                    else {
                        return
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(Color.blue)
            )
        }
    }
}

// FIXED: Removed the invalid .constant(...) wrapper call from the initialization chain
struct EditMemberView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let blankMember = Member(context: context)
        
        return EditMemberView(member: blankMember)
            .environment(\.managedObjectContext, context)
    }
}
