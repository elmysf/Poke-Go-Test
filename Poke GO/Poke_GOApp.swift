//
//  Poke_GOApp.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import SwiftUI

@main
struct Poke_GOApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
