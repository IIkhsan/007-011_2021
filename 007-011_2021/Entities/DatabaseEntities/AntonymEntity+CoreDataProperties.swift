//
//  AntonymEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Рустем on 16.12.2021.
//
//

import Foundation
import CoreData


extension AntonymEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AntonymEntity> {
        return NSFetchRequest<AntonymEntity>(entityName: "AntonymEntity")
    }

    @NSManaged public var antonym: String?

}

extension AntonymEntity : Identifiable {

}
