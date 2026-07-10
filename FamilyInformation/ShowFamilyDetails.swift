//
//  MemberDetailView.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/10/26.
//

import SwiftUI
import CoreData

struct MemberDetailView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss // Modern dismissal asset tool

    @ObservedObject var member: Member

    @State private var showEditSheet = false
    @State private var showDeleteAlert = false

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    // 1. Separated Header View Call
                    MemberHeaderCardView(member: member)
                        .padding(.horizontal)

                    // 2. Separated Info List View Call
                    MemberInfoListView(member: member)
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
                        dismiss() // Safely exit screen
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

// Xcode 26 Dynamic Macro Preview
#Preview {
    let context = PersistenceController.shared.container.viewContext
    let blankMember = Member(context: context)
    
    return NavigationStack {
        MemberDetailView(member: blankMember)
            .environment(\.managedObjectContext, context)
    }
}
