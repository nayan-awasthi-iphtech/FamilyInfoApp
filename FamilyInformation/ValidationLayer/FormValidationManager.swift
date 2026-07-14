//
//  FormValidationManager.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 14/07/26.
//

import Foundation

struct FormValidationManager {
    
    /// Pure validation engine checks if data satisfies architectural criteria
    static func checkValidity(name: String, occupation: String, phone: String, ageInput: String, address:String) -> Bool {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanOccupation = occupation.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanAddress = address.trimmingCharacters(in: .whitespacesAndNewlines)

        
        // 1. Mandatory Fields Null-Check
        guard !cleanName.isEmpty, !cleanOccupation.isEmpty, !cleanPhone.isEmpty else { return false }
        
        // 2. Bound Constraints Validation (Max 30 chars for Name)
        guard cleanName.count <= 30 else { return false }
        
        //Max 30 Char for Occupation
        guard cleanOccupation.count <= 30 else { return false }
        
        //Max 50 char for occupation
        guard cleanAddress.count <= 50 else { return false }
        
        // 3. Exact 10-Digit Phone Restriction
        let numericPhone = cleanPhone.filter { $0.isNumber }
        guard numericPhone.count == 10 && cleanPhone.count == 10 else { return false }
        
        // 4. Age Boundary Limits
        if let age = Int16(ageInput), age > 0 && age < 150 {
            return true
        }
        
        return false
    }
    
    /// Universal numeric filter that trims text and cuts string beyond maximum threshold limits
    static func sanitizeNumeric(input: String, maxLength: Int) -> String {
        let filtered = input.filter { $0.isNumber }
        return String(filtered.prefix(maxLength))
    }
    
    /// Universal standard text constraint limits filter
    static func sanitizeText(input: String, maxLength: Int) -> String {
        if input.count > maxLength {
            return String(input.prefix(maxLength))
        }
        return input
    }
}
