import SwiftUI

struct FirstPage: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("WakeMeUp")
                .font(.title)
            Text("Just another self-discipline alarm \n so lets get going!")
                .multilineTextAlignment(.center)
                .font(.title3)
        }
        .offset(y: -100)
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}

