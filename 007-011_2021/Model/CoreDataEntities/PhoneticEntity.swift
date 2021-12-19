//
//  FoneticEntity.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import Foundation
import CoreData

@objc(PhoneticEntity)
public class PhoneticEntity: NSManagedObject {

}

extension PhoneticEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneticEntity> {
        return NSFetchRequest<PhoneticEntity>(entityName: "PhoneticEntity")
    }

    @NSManaged public var audio: String?
    @NSManaged public var text: String?
    @NSManaged public var word: WordEntity?

}
