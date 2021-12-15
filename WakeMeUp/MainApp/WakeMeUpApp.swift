import SwiftUI
import CoreData

@main
struct WakeMeUpApp: App {
    @StateObject var viewRouter = ViewRouter()
    @StateObject var notificationRequestManager = NotificationRequestManager()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewRouter: viewRouter)
                .environmentObject(notificationRequestManager)
        }
    }
}
