import SwiftUI

struct SecondPage: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var notificationPageActive = false
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Walk To Stop")
                    .font(.title)
                Text("To stop the alarm \n take the desired steps \n to complete your activity!")
                    .multilineTextAlignment(.center)
                    .font(.title3)
            }
            .offset(y: -70)
            VStack {
                Button(action: goToNotificationPage, label: {
                    Text("Let's Go!")
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
    
    private func goToNotificationPage() {
        UserDefaults.standard.set(true, forKey: "didLaunchBefore")
        
        withAnimation {
            viewRouter.currentPage = .notificationRequest
        }
    }
}

struct SecondPage_Previews: PreviewProvider {
    static var previews: some View {
        SecondPage()
    }
}
