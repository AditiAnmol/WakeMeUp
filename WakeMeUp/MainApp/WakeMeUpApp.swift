import SwiftUI
import CoreData

@main
struct WakeMeUpApp: App {
    @StateObject var notificationRequestManager = NotificationRequestManager()
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewRouter: viewRouter)
                .environmentObject(notificationRequestManager)
                .environmentObject(viewRouter)
        }
    }
}
