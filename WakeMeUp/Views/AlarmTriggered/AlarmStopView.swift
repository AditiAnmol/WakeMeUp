import SwiftUI

struct AlarmStopView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var notificationRequestManager: NotificationRequestManager
    @Binding var currentPage: Int
    
    var alarmTime: Int16
    
    @ObservedObject private var alarmTriggeredData = AlarmTriggeredModel()
    
    init(currentPage: Binding<Int>, alarmTime: Int16) {
        self._currentPage = currentPage
        self.alarmTime = alarmTime
        
        self.alarmTriggeredData.activityDuration = alarmTime
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4763713479, green: 0.7747156024, blue: 0.7603972554, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.6949792504, blue: 0.7264153361, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack(spacing: 40) {
                Text("Let's walk for \(String(format: "%.1f", Double(alarmTime) / 60)) minutes!")
                    .font(.title)
                    .bold()
                CircleProgressView(value: $alarmTriggeredData.progress)
                    .frame(width: 250, height: 250, alignment: .center)
                Text(alarmTriggeredData.activityStatus)
                    .font(.title2)
                Spacer()
                if alarmTriggeredData.alarmStopped {
                    Button(action: stopActivity, label: {
                        Text("Finish")
                            .frame(width: 250, height: 45, alignment: .center)
                            .background(Color(#colorLiteral(red: 0.8862745098, green: 0.8352941176, blue: 0.8, alpha: 1)))
                            .cornerRadius(25)
                            .foregroundColor(.black)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .offset(y: -250)
                }
            }
            .offset(y: 125)
        }
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.all)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    
    private func stopActivity() {
        withAnimation {
            notificationRequestManager.notificationData = nil
            currentPage = 3
            viewRouter.currentPage = .alarm
        }
    }
}

struct AlarmStopView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmStopView(currentPage: .constant(2), alarmTime: 10)
    }
}
