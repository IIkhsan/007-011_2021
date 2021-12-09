//
//  CDPhonetics+CoreDataProperties.swift
//  
//
//  Created by Тимур Миргалиев on 02.12.2021.
//
//

import Foundation
import CoreData


extension CDPhonetics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPhonetics> {
        return NSFetchRequest<CDPhonetics>(entityName: "Phonetics")
    }

    @NSManaged public var audio: String?
    @NSManaged public var text: String?
    @NSManaged public var word_id: CDWord?

}
