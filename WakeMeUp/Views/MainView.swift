import SwiftUI

struct MainView: View {
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var notificationRequestManager: NotificationRequestManager
    
    var body: some View {
        if (notificationRequestManager.notificationData != nil) {
//            if (true) {
            MainTriggeredAlarmView()
                .environmentObject(notificationRequestManager)
                .environmentObject(viewRouter)
        } else if viewRouter.currentPage == .onboarding {
            Onboarding()
                .environmentObject(viewRouter)
        } else if viewRouter.currentPage == .notificationRequest {
            NotificationRequest()
                .environmentObject(viewRouter)
        } else {
            GeometryReader { geometry in
                NavigationView {
                    VStack {
                        Spacer()
                        if (viewRouter.currentPage == .alarm) {
                            AlarmListView()
                        }
                        Spacer()
                        ZStack {
                            HStack {
                                PlusMenu(size: geometry.size.width / 8)
                                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 28)
                                    .offset(y: -17)
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height / 8)
                            .background(Color("TabBarBackground").shadow(radius: 1))
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewRouter: ViewRouter(page: .alarm))
            .environmentObject(NotificationRequestManager())
    }
}

struct PlusMenu: View {
    @State private var showAddAlarm = false
    
    let size: CGFloat
   
    var body: some View {
        HStack(spacing: 50) {
            CircleButton(imageName: "plus", size: size/1.25) {
                self.showAddAlarm = true
            }
            .sheet(isPresented: $showAddAlarm) {
                AddAlarm()
            }
        }
        .transition(.scale)
    }
}

struct CircleButton: View {
    var imageName: String
    var size: CGFloat
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color("CenterButton"))
                    .frame(width: size, height: size)
                Image(systemName: imageName)
                    .foregroundColor(.white)
            }
        }
    }
}
