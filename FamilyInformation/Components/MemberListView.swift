import SwiftUI
import CoreData

struct MemberListView: View {

    // 1. Live Core Data fetch properties
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Member.name, ascending: true)],
        animation: .default
    )
    private var members: FetchedResults<Member>

    let searchText: String

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(members) { member in
                    
                    // FIXED: Safely unwrap optional Core Data string properties
                    if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        (member.name ?? "").localizedCaseInsensitiveContains(searchText) {

                        // FIXED: Added missing 'destination:' label parameter
                        NavigationLink(
                            destination: MemberDetailView(member: member)
                                .environment(\.managedObjectContext, viewContext)
                        ) {
                            MemberRowView(member: member)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

// FIXED: Cleaned preview scope for live background persistence instance
struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        return NavigationView {
            MemberListView(searchText: "")
                .environment(\.managedObjectContext, context)
        }
    }
}
