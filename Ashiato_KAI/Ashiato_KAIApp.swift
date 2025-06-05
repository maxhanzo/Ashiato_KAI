//
//  Ashiato_KAIApp.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 05/06/25.
//

import SwiftUI

@main
struct Ashiato_KAIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
