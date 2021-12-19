import SwiftUI

struct MainView: View {
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var notificationRequestManager: NotificationRequestManager
    
    var body: some View {
        if (notificationRequestManager.notificationData != nil) {
            AlarmActivityView()
        } else if viewRouter.currentPage == .onboarding {
            WelcomeScreens()
        } else if viewRouter.currentPage == .notificationRequest {
            NotificationRequest()
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
                                PlusIcon(size: geometry.size.width / 8)
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

// On click of plus button, shows the Add Alarm in sheet
struct PlusIcon: View {
    @State private var showAddAlarm = false
    
    let size: CGFloat
   
    var body: some View {
        HStack(spacing: 50) {
            CircleButton(iconName: "plus", buttonSize: size/1.25) {
                self.showAddAlarm = true
            }
            .sheet(isPresented: $showAddAlarm) {
                AddAlarm()
            }
        }
        .transition(.scale)
    }
}

// Button styling as circle
struct CircleButton: View {
    var iconName: String
    var buttonSize: CGFloat
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color("CenterButton"))
                    .frame(width: buttonSize, height: buttonSize)
                Image(systemName: iconName)
                    .foregroundColor(.white)
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
