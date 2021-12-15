//
//  SynonymsEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 12.12.2021.
//
//

import Foundation
import CoreData


extension SynonymsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SynonymsEntity> {
        return NSFetchRequest<SynonymsEntity>(entityName: "SynonymsEntity")
    }

    @NSManaged public var synonymValue: String
    @NSManaged public var definition: DefinitionsEntity?

}

extension SynonymsEntity : Identifiable {

}
