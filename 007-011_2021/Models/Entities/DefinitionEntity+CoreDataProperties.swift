//
//  DefinitionEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Семен Соколов on 24.11.2021.
//
//

import Foundation
import CoreData


extension DefinitionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionEntity> {
        return NSFetchRequest<DefinitionEntity>(entityName: "DefinitionEntity")
    }

    @NSManaged public var definition: String?
    @NSManaged public var example: String?
    @NSManaged public var meaning: MeaningEntity?

}

extension DefinitionEntity : Identifiable {

}
