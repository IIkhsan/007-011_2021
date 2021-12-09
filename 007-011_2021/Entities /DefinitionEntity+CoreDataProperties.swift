//
//  DefinitionEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 09.12.2021.
//
//

import Foundation
import CoreData


extension DefinitionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionEntity> {
        return NSFetchRequest<DefinitionEntity>(entityName: "Definition")
    }

    @NSManaged public var definition: String?
    @NSManaged public var example: String?

}

extension DefinitionEntity : Identifiable {

}
