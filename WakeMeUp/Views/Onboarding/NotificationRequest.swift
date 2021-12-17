import SwiftUI

struct NotificationRequest: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Image("")
                Text("To stop the alarm \n take the desired steps \n to complete your activity!")
                    .multilineTextAlignment(.center)
                    .font(.title3)
            }
            .offset(y: -70)
            VStack {
                Button(action: requestNotification, label: {
                    Text("Allow notifications")
                        .frame(width: 250, height: 45, alignment: .center)
                        .background(Color("TabBarHighlight"))
                        .cornerRadius(25)
                        .foregroundColor(.white)
                })
                .buttonStyle(PlainButtonStyle())
            }
            .offset(y: 60)
        }
    }
    
    private func requestNotification() {
        NotificationController.shared.requestNotificationPermission {
            withAnimation {
                DispatchQueue.main.async {
                    self.viewRouter.currentPage = .alarm
                }
            }
        }
    }
}

struct NotificationRequest_Previews: PreviewProvider {
    static var previews: some View {
        NotificationRequest()
    }
}
