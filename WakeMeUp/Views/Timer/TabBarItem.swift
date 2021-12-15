//
//  TabBarItem.swift
//  WakeMeUp
//
//  Created by Jainam Sheth on 12/14/21.
//

import SwiftUI

struct TabBarItem: View {
    @StateObject var viewRouter: ViewRouter
    
    var width: CGFloat
    var height: CGFloat
    var pageName: Page
    var iconName: String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top)
                .foregroundColor(viewRouter.currentPage == pageName ? Color("TabBarHighlight") : .gray)
            Spacer()
        }
        .onTapGesture {
            self.viewRouter.currentPage = pageName
        }
    }
}
