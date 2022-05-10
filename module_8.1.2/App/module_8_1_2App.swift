//
//  module_8_1_2App.swift
//  module_8.1.2
//
//  Created by Sanjar Aslonov on 06/05/22.
//

import SwiftUI

@main
struct module_8_1_2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(Network())
        }
    }
}
