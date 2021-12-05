//
//  WakeMeUpApp.swift
//  WakeMeUp
//
//  Created by Aditi Anmol on 05/12/21.
//

import SwiftUI

@main
struct WakeMeUpApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
