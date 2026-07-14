//
//  AppState.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 13/07/26.
//

import SwiftUI

class AppState: ObservableObject {
    // Pure app ke liye single shared instance (Singleton Pattern)
    static let shared = AppState()
    
    // Core engine jo local storage se direct dark mode state manage karega
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    // Private init ensure karega ki koi bahar se naya obj na bana sake
    private init() {}
}
