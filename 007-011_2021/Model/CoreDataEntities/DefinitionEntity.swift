//
//  DefinitionEntity.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import CoreData

@objc(DefinitionEntity)
public class DefinitionEntity: NSManagedObject {

}

extension DefinitionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionEntity> {
        return NSFetchRequest<DefinitionEntity>(entityName: "DefinitionEntity")
    }

    @NSManaged public var definition: String?
    @NSManaged public var example: String?
    @NSManaged public var antonyms: [String]?
    @NSManaged public var synonyms: [String]?
    @NSManaged public var meaning: MeaningEntity?

}
