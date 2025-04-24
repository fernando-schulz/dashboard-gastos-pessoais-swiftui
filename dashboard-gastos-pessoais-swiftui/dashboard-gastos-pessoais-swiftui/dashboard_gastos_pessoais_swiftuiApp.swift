//
//  dashboard_gastos_pessoais_swiftuiApp.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 21/04/25.
//

import SwiftUI

@main
struct dashboard_gastos_pessoais_swiftuiApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentViewController(viewModel: ContentViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
