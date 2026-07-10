import SwiftUI
import CoreData

struct EditMemberView: View {

    @ObservedObject var member: Member

    @Environment(\.presentationMode) var presentationMode
    
    // Core Data environment viewContext to save structural changes
    @Environment(\.managedObjectContext) private var viewContext

    // Local UI state variables for editing the image
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false

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

                        // 0. Profile Photo Section
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
                                        } else if let imageData = member.image, let savedUiImage = UIImage(data: imageData) {
                                            Image(uiImage: savedUiImage)
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
                            .buttonStyle(PlainButtonStyle())

                            Text("Change Photo")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)

                        // 1. Personal Information
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Personal Information")
                                .font(.headline)

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
                    
                    // Convert chosen custom image to updated Binary Data values
                    if let uiImage = selectedImage {
                        member.image = uiImage.jpegData(compressionQuality: 0.7)
                    }
                    
                    // Explicitly save the context modifications to the persistent container
                    do {
                        try viewContext.save()
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Failed to save edited context details: \(error.localizedDescription)")
                    }
                }
                .foregroundColor(Color.blue)
            )
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            // Populate the UI picker image buffer if binary asset exists on startup
            .onAppear {
                if let savedBinaryData = member.image {
                    selectedImage = UIImage(data: savedBinaryData)
                }
            }
        }
    }
}

struct EditMemberView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let blankMember = Member(context: context)
        
        return EditMemberView(member: blankMember)
            .environment(\.managedObjectContext, context)
    }
}
