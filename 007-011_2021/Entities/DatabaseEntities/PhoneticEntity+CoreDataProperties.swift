//
//  PhoneticEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Рустем on 16.12.2021.
//
//

import Foundation
import CoreData


extension PhoneticEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneticEntity> {
        return NSFetchRequest<PhoneticEntity>(entityName: "PhoneticEntity")
    }

    @NSManaged public var text: String?
    @NSManaged public var audio: String?

}

extension PhoneticEntity : Identifiable {

}
