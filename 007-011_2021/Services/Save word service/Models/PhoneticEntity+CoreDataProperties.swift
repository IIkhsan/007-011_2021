//
//  PhoneticEntity+CoreDataProperties.swift
//  
//
//  Created by Роман Сницарюк on 24.11.2021.
//
//

import Foundation
import CoreData


extension PhoneticEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneticEntity> {
        return NSFetchRequest<PhoneticEntity>(entityName: "PhoneticEntity")
    }

    @NSManaged public var audio: String?
    @NSManaged public var name: String
    @NSManaged public var word: WordEntity?

}
