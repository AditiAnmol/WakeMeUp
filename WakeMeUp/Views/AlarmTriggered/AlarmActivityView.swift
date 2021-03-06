import SwiftUI

struct AlarmActivityView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var notificationRequestManager: NotificationRequestManager

    @State private var currentPage = 1
    @State private var alarmName = "Wake up"
    @State private var alarmTime: Int16 = 0

    var body: some View {
        Group {
            switch currentPage {
                case 1:
                    AlarmNotificationView(currentPage: $currentPage, alarmName: alarmName, alarmTime: alarmTime)
                case 2:
                    AlarmStopView(currentPage: $currentPage, alarmTime: alarmTime)
                case 3:
                    MainView(viewRouter: viewRouter)
                default:
                    EmptyView()
            }
        }
        .onAppear(perform: {
            alarmName = (notificationRequestManager.notificationData.notification.request.content.userInfo["title"] as? String)!
            let duration = (notificationRequestManager.notificationData.notification.request.content.userInfo["duration"] as? String)!
            let str = duration.split(separator: " ")
            alarmTime = Int16(Double(str[0])! * 60)
        })
    }
}

struct MainTriggeredAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmActivityView()
    }
}
