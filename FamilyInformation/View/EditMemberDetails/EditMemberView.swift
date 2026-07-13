import SwiftUI
import CoreData
import PhotosUI

struct EditMemberView: View {
    @ObservedObject var member: Member
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil

    var body: some View {
        NavigationStack {
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
                        ProfileImagePickerView(selectedItem: $selectedItem, selectedImage: $selectedImage)

                        PersonalInfoSection(member: member)
                        
                        ContactInfoSection(member: member)
                        
                        ProfessionalInfoSection(member: member)
                        
                        BirthdayInfoSection(member: member)
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Edit Member")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        guard let name = member.name, !name.isEmpty,
                              member.age > 0,
                              let rel = member.relationship, !rel.isEmpty,
                              let phone = member.phone, !phone.isEmpty
                        else { return }
                        
                        if let uiImage = selectedImage {
                            member.image = uiImage.jpegData(compressionQuality: 0.7)
                        }
                        
                        do {
                            try viewContext.save()
                            NotificationManager.shared.sheduleBirthdayNotification(for: member)
                            dismiss()
                        } catch {
                            print("Failed to save edited context details: \(error.localizedDescription)")
                        }
                    }
                    .foregroundColor(Color.blue)
                }
            }
            .onAppear {
                if let savedBinaryData = member.image {
                    selectedImage = UIImage(data: savedBinaryData)
                }
            }
        }
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    let blankMember = Member(context: context)
    return EditMemberView(member: blankMember)
        .environment(\.managedObjectContext, context)
}
