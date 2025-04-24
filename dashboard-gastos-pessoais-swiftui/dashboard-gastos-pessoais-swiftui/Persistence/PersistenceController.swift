//
//  PersistenceController.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 23/04/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DatabaseAppModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores{ _, error in
            if let error = error as NSError? {
                fatalError("Erro ao carregar o Core Data: \(error), \(error.userInfo)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
}
