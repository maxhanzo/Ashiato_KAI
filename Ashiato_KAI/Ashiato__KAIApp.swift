//
//  Ashiato__KAIApp.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import SwiftUI

@main
struct Ashiato__KAIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
