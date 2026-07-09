import SwiftUI
import CoreData

struct BirthdayCardView: View {

    let birthdayMembers: [Member]

    var body: some View {
        if birthdayMembers.isEmpty {

            VStack(spacing: 15) {

                Image(systemName: "gift.fill")
                    .font(.system(size: 35))
                    .foregroundColor(Color("Birthday"))

                Text("Today's Birthday")
                    .font(.headline)

                Text("No birthdays today")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Your next celebration is coming soon 🎉")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 25)
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
            .padding(.horizontal)

        } else {

            VStack(alignment: .leading, spacing: 18) {

                HStack {

                    Image(systemName: "gift.fill")
                        .font(.title2)

                    VStack(alignment: .leading, spacing: 2) {

                        Text("Today's Birthday")
                            .font(.headline)

                        Text("Celebrate your loved ones")
                            .font(.caption)
                            .opacity(0.9)
                    }

                    Spacer()
                }
                .foregroundColor(.white)

                ForEach(birthdayMembers) { member in

                    HStack(spacing: 15) {

                        ZStack {

                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 60, height: 60)

                            // ✅ FIXED: Safely unwrapped optional core data string
                            Image(systemName: member.image ?? "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }

                        VStack(alignment: .leading, spacing: 5) {

                            // ✅ FIXED: Safely unwrapped optional core data name
                            Text(member.name ?? "Unknown")
                                .font(.headline)
                                .foregroundColor(.white)

                            Text("🎉 Happy Birthday!")
                                .font(.subheadline)
                                .foregroundColor(Color.white.opacity(0.95))

                            Text("Have a wonderful year ahead!")
                                .font(.caption)
                                .foregroundColor(Color.white.opacity(0.85))
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color.white.opacity(0.12))
                    .cornerRadius(15)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("Birthday"),
                        Color("BrandBlue")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(
                color: Color("BrandBlue").opacity(0.25),
                radius: 10,
                x: 0,
                y: 6
            )
            .padding(.horizontal)
        }
    }
}

// ✅ FIXED: Preview converted to match clean scratch entity structure
struct BirthdayCardView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let blankMember = Member(context: context)

        return BirthdayCardView(birthdayMembers: [blankMember])
            .environment(\.managedObjectContext, context)
    }
}


