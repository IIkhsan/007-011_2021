//
//  SynonymEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Рустем on 16.12.2021.
//
//

import Foundation
import CoreData


extension SynonymEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SynonymEntity> {
        return NSFetchRequest<SynonymEntity>(entityName: "SynonymEntity")
    }

    @NSManaged public var synonym: String?

}

extension SynonymEntity : Identifiable {

}
