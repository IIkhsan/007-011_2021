//
//  AntonymsEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 12.12.2021.
//
//

import Foundation
import CoreData


extension AntonymsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AntonymsEntity> {
        return NSFetchRequest<AntonymsEntity>(entityName: "AntonymsEntity")
    }

    @NSManaged public var antonymValue: String
    @NSManaged public var definition: DefinitionsEntity?

}

extension AntonymsEntity : Identifiable {

}
