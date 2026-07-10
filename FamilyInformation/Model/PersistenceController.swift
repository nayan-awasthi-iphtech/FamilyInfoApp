
import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FamilyModel")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                #if DEBUG
                print("Core data issue is coming while loading: \(error.localizedDescription)")
                #endif
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                #if DEBUG
                print("Core data loaded successfully")
                #endif
            }
        }
        
        // Yeh line images ko edit karte hi turant baaki saari screens par sync (update) kar degi
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
