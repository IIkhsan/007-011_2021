//
//  CDWord+CoreDataProperties.swift
//  
//
//  Created by Илья Желтиков on 16.12.2021.
//
//

import Foundation
import CoreData


extension CDWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWord> {
        return NSFetchRequest<CDWord>(entityName: "CDWord")
    }

    @NSManaged public var origin: String?
    @NSManaged public var phonetic: String?
    @NSManaged public var word: String?
    @NSManaged public var meanings: NSSet?
    @NSManaged public var phonetics: NSSet?

}
