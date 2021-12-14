//
//  Definition+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Семен Соколов on 24.11.2021.
//
//

import Foundation
import CoreData


extension Definition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Definition> {
        return NSFetchRequest<Definition>(entityName: "Definition")
    }

    @NSManaged public var definition: String?
    @NSManaged public var example: String?
    @NSManaged public var meaning: Meaning?

}

extension Definition : Identifiable {

}
