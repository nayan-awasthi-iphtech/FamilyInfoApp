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
            // FIXED: id: \.objectID lagane se SwiftUI har row ko alag aur unique treat karega
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
    }
}
