import CoreData

// Storing the context, changed according to app needs from auto generation
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
