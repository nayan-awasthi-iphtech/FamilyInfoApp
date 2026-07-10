import SwiftUI
import CoreData

struct MemberDetailView: View {

    // 1. Core Data viewContext for permanent operations
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    // 2. FIXED: ObservedObject ensures properties are read as values, not bindings
    @ObservedObject var member: Member

    @State private var showEditSheet = false
    @State private var showDeleteAlert = false

    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long // FIXED: Corrected typo from letStyle to formatter.dateStyle
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.75)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 250)
                        .cornerRadius(25)
                        .shadow(color: Color.blue.opacity(0.3), radius: 10)

                        VStack(spacing: 15) {
                            
                            // FIXED: Added length check to stop corrupted buffer crashes
                            Group {
                                if let imageData = member.image, imageData.count > 0, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.blue)
                                        .padding(22)
                                }
                            }
                            .frame(width: 134, height: 134)
                            .background(Color.white)
                            .clipShape(Circle())

                            Text(member.name ?? "Unknown Name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text(member.relationship ?? "Family")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 6)
                                .background(Color.white.opacity(0.25))
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.horizontal)

                    // FIXED: Restored 'tilte:' parameter label to match your custom MemberInfoCard implementation
                    VStack(spacing: 18) {
                        MemberInfoCard(
                            icon: "calendar",
                            tilte: "Birthday",
                            value: member.birthday != nil ? formatter.string(from: member.birthday!) : "Not Provided"
                        )

                        MemberInfoCard(
                            icon: "person.fill",
                            tilte: "Age",
                            value: "\(member.age) Years"
                        )

                        MemberInfoCard(
                            icon: "briefcase.fill",
                            tilte: "Occupation",
                            value: member.occupation ?? "None"
                        )

                        MemberInfoCard(
                            icon: "phone.fill",
                            tilte: "Phone",
                            value: member.phone ?? "None"
                        )

                        MemberInfoCard(
                            icon: "location.fill",
                            tilte: "Address",
                            value: member.address ?? "None"
                        )
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
        }
        .navigationTitle("Member Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { showEditSheet = true }) {
                    Image(systemName: "square.and.pencil")
                }

                Button(action: { showDeleteAlert = true }) {
                    Image(systemName: "trash").foregroundColor(.red)
                }
            }
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete Member"),
                message: Text("Are you sure you want to delete this member?"),
                primaryButton: .destructive(Text("Delete"), action: {
                    self.viewContext.delete(self.member)
                    do {
                        try self.viewContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Failed to delete: \(error.localizedDescription)")
                    }
                }),
                secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $showEditSheet, onDismiss: {
            if viewContext.hasChanges {
                try? viewContext.save()
            }
        }) {
            EditMemberView(member: member)
                .environment(\.managedObjectContext, viewContext)
        }
    }
}

struct MemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let blankMember = Member(context: context)

        return NavigationView {
            MemberDetailView(member: blankMember)
                .environment(\.managedObjectContext, context)
        }
    }
}
