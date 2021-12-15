import SwiftUI

enum Page {
    case onboarding
    case notificationRequest
    case alarm
    case timer
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            currentPage = .onboarding
        } else {
            currentPage = .alarm
        }
    }
}

