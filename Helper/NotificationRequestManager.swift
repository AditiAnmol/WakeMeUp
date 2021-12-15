import SwiftUI

class NotificationRequestManager: NSObject, ObservableObject {
    @Published var notificationData: UNNotificationResponse!
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

extension NotificationRequestManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self.notificationData = response
        
        completionHandler()
    }
}
