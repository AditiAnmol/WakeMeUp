import SwiftUI

/*
 Shows the welcome screen for the first time users.
 */
struct WelcomeScreens: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var currentTab = 0
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = #colorLiteral(red: 0.4754182696, green: 0.7763083577, blue: 0.7592564225, alpha: 1)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
                    FirstPage()
                        .tag(1)
                    SecondPage()
                        .tag(2)
                })
            .environmentObject(viewRouter)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreens()
    }
}
