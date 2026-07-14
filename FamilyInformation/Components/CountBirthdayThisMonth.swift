//
//  CountBirthdayThisMonth.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 13/07/26.
//

import SwiftUI
import CoreData

enum RelationshipType: String, CaseIterable, Identifiable, Hashable{
    case father = "Father"
    case mother = "Mother"
    case brother = "Brother"
    case sister = "Sister"
    case son = "Son"
    case daughter = "Daughter"
    case husband = "Husband"
    case wife = "Wife"
    case grandfather = "Grandfather"
    case grandmother = "Grandmother"
    case uncle = "Uncle"
    case aunt = "Aunt"
    case cousin = "Cousin"
    case friend = "Friend"
    case other = "Other"
    
    var id: String {self.rawValue}
    var displayName: String {
        return self.rawValue
    }
    
    /// Checks if a given raw string matches any immediate family member cases
    static func isImmediate(_ relationship: String) -> Bool {
        let cleanRelation = relationship.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let immediateCases = ["father","mother", "brother", "sister", "son", "daughter", "husband", "wife", "grandfather", "grandmother", "uncle", "aunt", "cousin", "friend", "other"]
        return immediateCases.contains(cleanRelation)
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
