import UserNotifications

class NotificationController {
    static let shared = NotificationController()
    
    var isNotificationPermissionProvided: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isNotificationPermissionProvided")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isNotificationPermissionProvided")
        }
    }
    
    // Schedules the notification for all the days selected and as per the selected time
    func scheduleNotifications(id: String, title: String, for days: [(String, Bool)], on date: Date, stopDuration duration: String, musicName: String) {
        let unmutableNotifContent = UNMutableNotificationContent()
        unmutableNotifContent.title = title
        unmutableNotifContent.subtitle = "Let's get moving!"
        unmutableNotifContent.userInfo = [
            "title": title,
            "duration": duration,
            "music": musicName
        ]
        unmutableNotifContent.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(musicName).wav"))
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        // For each day selected, add notification in Notification Center
        for day in days {
            if day.1 {
                var dateComponents = DateComponents()
                dateComponents.hour = hour
                dateComponents.minute = minute
                dateComponents.weekday = Constants.DAYS[day.0]
                dateComponents.timeZone = .current
                
                let notifTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let notifRequest = UNNotificationRequest(identifier: id, content: unmutableNotifContent, trigger: notifTrigger)
                UNUserNotificationCenter.current().add(notifRequest)
            }
        }
    }
    
    // Removes all the pending notification requests
    func cancelScheduledNotification(for id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    // Requests user for Allowing notification from this app
    func requestNotificationPermission(completion: @escaping () -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.isNotificationPermissionProvided = true
            } else {
                self.isNotificationPermissionProvided = false
            }
            
            completion()
        }
    }
}

