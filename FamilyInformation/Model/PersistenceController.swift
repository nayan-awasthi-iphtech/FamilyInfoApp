//
//  PersistenceController.swift
//  FamilyInformation
//
//  Created by iPHTech4 on 7/9/26.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "FamilyModel")
        container.loadPersistentStores{(_, error) in
            if let error = error as NSError? {
                
                if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                    print("Core data issue is coming while loading")
                }
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("Core data loaded successfuly")
            }
        }
    }
}
