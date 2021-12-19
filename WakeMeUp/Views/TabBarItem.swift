import SwiftUI

struct TabBarItem: View {
    @StateObject var viewRouter: ViewRouter
    
    var currentPage: Page
    var icon: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top)
                .foregroundColor(viewRouter.currentPage == currentPage ? Color("TabBarHighlight") : .gray)
            Spacer()
        }
        .onTapGesture {
            self.viewRouter.currentPage = currentPage
        }
    }
}
