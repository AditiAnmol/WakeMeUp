import Foundation
import CoreMotion

class ActivityRecognizer {
    var activityManager: CMMotionActivityManager!
    
    var doingActivity = false
    
    init() {
        self.activityManager = CMMotionActivityManager()
        self.activityManager.startActivityUpdates(to: .main) { activity in
            if (activity?.stationary)! {
                self.doingActivity = false
            } else {
                self.doingActivity = true
            }
        }
    }
}
