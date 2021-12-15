//
//  SynonymEntity+CoreDataClass.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 28.11.2021.
//
//

import Foundation
import CoreData

@objc(SynonymEntity)
public class SynonymEntity: NSManagedObject {

}

extension SynonymEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SynonymEntity> {
        return NSFetchRequest<SynonymEntity>(entityName: "SynonymEntity")
    }

    @NSManaged public var synonym: String?

}

extension SynonymEntity : Identifiable {

}

