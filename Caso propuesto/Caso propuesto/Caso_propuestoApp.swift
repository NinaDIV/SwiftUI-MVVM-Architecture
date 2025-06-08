//
//  Caso_propuestoApp.swift
//  Caso propuesto
//
//  Created by MILWARD on 2/06/25.
//

import SwiftUI

@main
struct Caso_propuestoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
