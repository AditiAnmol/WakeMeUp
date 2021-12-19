import Combine
import CoreData

class AlarmController: NSObject, ObservableObject {
    static let shared = AlarmController()
    
    var alarms = CurrentValueSubject<[Alarm], Never>([])
    private let alarmFetchController: NSFetchedResultsController<Alarm>
    
    // Fetches the alarm data from context and stores to its local state
    private override init() {
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        alarmFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistenceController.shared.persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        super.init()
        
        alarmFetchController.delegate = self
        
        do {
            try alarmFetchController.performFetch()
            alarms.value = alarmFetchController.fetchedObjects ?? []
        } catch {
            // Error handling
        }
    }
    
    // Adds the alarm to the context
    func add(id: String, name: String, time: Date, music: String, activityDuration: Int16, repeats: [String]) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        let alarm = Alarm(context: context)

        alarm.active = true
        alarm.id = id
        alarm.name = name
        alarm.time = time
        alarm.music = music
        alarm.activityDuration = activityDuration
        alarm.repeatOn = repeats

        try? context.save()
    }
    
    // delete the current alarm from context
    func delete(alarm: Alarm) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        
        context.delete(alarm)
        
        try? context.save()
    }
    
    // Edit existing alarm and save to context
    func edit(alarm: Alarm, name: String, time: Date, music: String, activityDuration: Int16, repeats: [String]) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        alarm.name = name
        alarm.time = time
        alarm.music = music
        alarm.activityDuration = activityDuration
        alarm.repeatOn = repeats
        
        try? context.save()
    }
    
    // Toggles the active state of the current alarm on tap of the alarm
    func toggle(alarm: Alarm) {
        let context = PersistenceController.shared.persistentContainer.viewContext
        alarm.active.toggle()
        
        try? context.save()
    }
}

extension AlarmController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let alarms = controller.fetchedObjects as? [Alarm] else {
            return
        }
        
        self.alarms.value = alarms
    }
}


