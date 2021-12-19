import Foundation
import CoreMotion

// Used to track and update the activity state
class ActivityRecognizer {
    var activityManager: CMMotionActivityManager!
    
    var isActivityGoingOn = false
    
    init() {
        self.activityManager = CMMotionActivityManager()
        self.activityManager.startActivityUpdates(to: .main) { activity in
            if (activity?.stationary)! {
                self.isActivityGoingOn = false
            } else {
                self.isActivityGoingOn = true
            }
        }
    }
}
