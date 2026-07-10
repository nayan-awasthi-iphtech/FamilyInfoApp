import Foundation

struct MemberHelper {

    static func todaysBirthdays(from members: [Member]) -> [Member] {
        let calendar = Calendar.current
        let today = calendar.dateComponents([.day, .month], from: Date())

        return members.filter { member in
            guard let memberBirthday = member.birthday else {
                return false
            }

            let birthday = calendar.dateComponents([.day, .month], from: memberBirthday)

            return birthday.day == today.day && birthday.month == today.month
        }
    }
}
