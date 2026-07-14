import SwiftUI
import CoreData
import PhotosUI

struct EditMemberView: View {
    @ObservedObject var member: Member
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var appState: AppState // Global theme listener injected
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    
    private var isValidForm: Bool {
        return FormValidationManager.checkValidity(
            name: member.name ?? "",
            occupation: member.occupation ?? "",
            phone: member.phone ?? "",
            ageInput: member.age > 0 ? String(member.age) : "",
            address: member.address ?? ""
        )
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fix: Gradient parameters fully sync with current UI style variations
                LinearGradient(
                    gradient: Gradient(colors: appState.isDarkMode ? [
                        Color(red: 0.16, green: 0.18, blue: 0.22),
                        Color(red: 0.12, green: 0.14, blue: 0.17)
                    ] : [
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
                            .onChange(of: member.name ?? "") { _, newValue in
                                member.name = FormValidationManager.sanitizeText(input: newValue, maxLength: 30)
                            }
                        
                        ContactInfoSection(member: member)
                            .onChange(of: member.phone ?? "") { _, newValue in
                                member.phone = FormValidationManager.sanitizeNumeric(input: newValue, maxLength: 10)
                            }
                        
                        ProfessionalInfoSection(member: member)
                            .onChange(of: member.occupation ?? "") { _, newValue in
                                member.occupation = FormValidationManager.sanitizeText(input: newValue, maxLength: 30)
                            }
                        
                        BirthdayInfoSection(member: member)
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Edit Member")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(appState.isDarkMode ? .white.opacity(0.7) : .primary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        guard isValidForm else {
                            return
                        }
                        
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
                    .foregroundColor(appState.isDarkMode ? .cyan : Color.blue)
                    .font(.system(size: 16, weight: .bold))
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
