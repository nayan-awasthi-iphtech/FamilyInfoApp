    import SwiftUI
    import CoreData

    struct MemberListView: View {

        @Environment(\.managedObjectContext) private var viewContext
        
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Member.name, ascending: true)],
            animation: .default
        )
        private var members: FetchedResults<Member>

        let searchText: String

        var body: some View {
            LazyVStack(spacing: 12) {
                
                ForEach(members, id: \.objectID) { member in
                    if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        (member.name ?? "").localizedCaseInsensitiveContains(searchText) {
                        NavigationLink(destination: MemberDetailView(member: member).environment(\.managedObjectContext, viewContext)) {
                            MemberRowView(member: member)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
                .onAppear {
                        print("--- CORE DATA MEMBERS START ---")
                        print("Total Count: \(members.count)")
                        
                        // Core data elements ko iterate karke print kar rahe hain
                        for m in members {
                            print("Member Name: \(m.name ?? "Nil Name"), ID: \(m.objectID)")
                        }
                        print("--- CORE DATA MEMBERS END ---")
                    }
        }
    }
