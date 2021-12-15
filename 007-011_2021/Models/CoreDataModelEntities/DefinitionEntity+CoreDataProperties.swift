//
//  DefinitionEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Marat Giniyatov on 12.12.2021.
//
//

import Foundation
import CoreData


extension DefinitionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionEntity> {
        return NSFetchRequest<DefinitionEntity>(entityName: "DefinitionEntity")
    }

    @NSManaged public var definition: String?
//    @NSManaged public var antonym: [String]
//    @NSManaged public var synonym: [String]
    @NSManaged public var example: String?
    @NSManaged public var meaning: MeaningEntity?

}

extension DefinitionEntity : Identifiable {

}
