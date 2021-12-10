//
//  DefinitionEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 08.12.2021.
//
//

import Foundation
import CoreData

@objc(DefinitionEntity)
public class DefinitionEntity: NSManagedObject {}
extension DefinitionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionEntity> {
        return NSFetchRequest<DefinitionEntity>(entityName: "DefinitionEntity")
    }

    @NSManaged public var definition: String?
    @NSManaged public var example: String?
    @NSManaged public var meanings: MeaningEntity?
}
