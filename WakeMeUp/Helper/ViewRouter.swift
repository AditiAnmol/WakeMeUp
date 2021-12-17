import SwiftUI

enum Page {
    case onboarding
    case notificationRequest
    case alarm
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
    
    init(page: Page) {
        currentPage = page
    }
}

