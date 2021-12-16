//
//  PhoneticEntity+CoreDataProperties.swift
//  
//
//  Created by Alexandr Onischenko on 16.12.2021.
//
//

import Foundation
import CoreData


extension PhoneticEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneticEntity> {
        return NSFetchRequest<PhoneticEntity>(entityName: "PhoneticEntity")
    }

    @NSManaged public var audio: String?
    @NSManaged public var text: String?
    @NSManaged public var word: WordEntity?

}
