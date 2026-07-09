//
//  FamilyInformationApp.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/7/26.
//

import SwiftUI

@main
struct FamilyInformationApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                             persistenceController.container.viewContext)
        }
    }
}
