//
//  DefinitionsEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//
//

import Foundation
import CoreData


extension DefinitionsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionsEntity> {
        return NSFetchRequest<DefinitionsEntity>(entityName: "DefinitionsEntity")
    }

    @NSManaged public var definition: String
    @NSManaged public var example: String
    @NSManaged public var meanings: MeaningsEntity

}

extension DefinitionsEntity : Identifiable {

}
