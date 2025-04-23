//
//  Entity+CoreDataProperties.swift
//  dashboard-gastos-pessoais-swiftui
//
//  Created by Fernando Schulz on 21/04/25.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}

extension Entity : Identifiable {

}
