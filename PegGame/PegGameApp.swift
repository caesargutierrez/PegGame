//
//  PegGameApp.swift
//  PegGame
//
//  Created by Caesar Gutierrez on 12/6/23.
//

import SwiftUI

@main
struct PegGameApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
