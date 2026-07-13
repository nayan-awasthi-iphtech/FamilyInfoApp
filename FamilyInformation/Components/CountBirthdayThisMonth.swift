//
//  CountBirthdayThisMonth.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 13/07/26.
//

import SwiftUI
import CoreData

enum RelationshipType: String, CaseIterable {
    case mother
    case father
    case sister
    case brother
    case spouse
    case husband
    case wife
    case son
    case daughter
    
    /// Checks if a given raw string matches any immediate family member cases
    static func isImmediate(_ relationship: String) -> Bool {
        let cleanRelation = relationship.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        return RelationshipType(rawValue: cleanRelation) != nil
    }
}

extension FetchedResults where Element == Member {
    
    /// Counts family members marked as favorites permanently
        func countFavorites() -> Int {
            return self.filter { $0.isFavorite }.count
        }
        
        /// Counts immediate family members based on typical direct relationships
       func countImmediate() -> Int {
            return self.filter { member in
                guard let relation = member.relationship else { return false }
                return RelationshipType.isImmediate(relation)
            }.count
        }
        
        /// Counts extended family members (anything that has a relationship but isn't immediate)
        func countExtended() -> Int {
            return self.filter { member in
                guard let relation = member.relationship, !relation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
                return !RelationshipType.isImmediate(relation)
            }.count
        }
    
    /// Counts the number of family members who have birthdays in the current calendar month.
    func countBirthdaysThisMonth() -> Int {
        let currentMonth = Calendar.current.component(.month, from: Date())
        
        return self.filter { member in
            // Safely unwrap the birthday property from your Core Data Member entity
            guard let birthday = member.birthday else { return false }
            return Calendar.current.component(.month, from: birthday) == currentMonth
        }.count
    }
}
