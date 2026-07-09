//
//  MemberHelper.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/8/26.
//

import Foundation

struct MemberHelper {

    static func todaysBirthdays(from members: [Member]) -> [Member] {

        let calendar = Calendar.current
        let today = calendar.dateComponents([.day, .month], from: Date())

        return members.filter { member in
            // Core Data optional Date ko safely unwrap karne ke liye guard let use kiya
            guard let memberBirthday = member.birthday else {
                return false // Agar birthday nil hai, toh is member ko skip kar do
            }

            let birthday = calendar.dateComponents([.day, .month], from: memberBirthday)

            return birthday.day == today.day &&
                   birthday.month == today.month
        }
    }
}
