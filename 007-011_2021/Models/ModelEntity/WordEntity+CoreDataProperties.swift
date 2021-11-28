//
//  WordEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Даниил Багаутдинов on 23.11.2021.
//
//

import Foundation
import CoreData


extension WordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var word: String
    @NSManaged public var meanings: NSSet
    @NSManaged public var phonetics: NSSet

}

extension WordEntity : Identifiable {

}
