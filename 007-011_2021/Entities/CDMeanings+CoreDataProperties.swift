//
//  CDMeanings+CoreDataProperties.swift
//  
//
//  Created by Илья Желтиков on 16.12.2021.
//
//

import Foundation
import CoreData


extension CDMeanings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMeanings> {
        return NSFetchRequest<CDMeanings>(entityName: "CDMeanings")
    }

    @NSManaged public var partOfSpeech: String?
    @NSManaged public var definitions: NSSet?
    @NSManaged public var word_id: CDWord?

}
