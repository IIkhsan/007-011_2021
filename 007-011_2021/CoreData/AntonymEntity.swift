//
//  AntonymEntity+CoreDataClass.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 28.11.2021.
//
//

import Foundation
import CoreData

@objc(AntonymEntity)
public class AntonymEntity: NSManagedObject {

}

extension AntonymEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AntonymEntity> {
        return NSFetchRequest<AntonymEntity>(entityName: "AntonymEntity")
    }

    @NSManaged public var antonym: String?

}

extension AntonymEntity : Identifiable {

}
