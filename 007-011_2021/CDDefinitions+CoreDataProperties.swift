//
//  CDDefinitions+CoreDataProperties.swift
//  
//
//  Created by Тимур Миргалиев on 02.12.2021.
//
//

import Foundation
import CoreData


extension CDDefinitions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDDefinitions> {
        return NSFetchRequest<CDDefinitions>(entityName: "Definitions")
    }

    @NSManaged public var definition: String?
    @NSManaged public var example: String?
    @NSManaged public var meanings_id: CDMeanings?

}
