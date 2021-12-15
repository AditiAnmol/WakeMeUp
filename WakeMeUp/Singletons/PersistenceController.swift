import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WakeMeUp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
