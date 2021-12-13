//
//  CDMeanings+CoreDataProperties.swift
//  
//
//  Created by Тимур Миргалиев on 11.12.2021.
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

// MARK: Generated accessors for definitions
extension CDMeanings {

    @objc(addDefinitionsObject:)
    @NSManaged public func addToDefinitions(_ value: CDDefinitions)

    @objc(removeDefinitionsObject:)
    @NSManaged public func removeFromDefinitions(_ value: CDDefinitions)

    @objc(addDefinitions:)
    @NSManaged public func addToDefinitions(_ values: NSSet)

    @objc(removeDefinitions:)
    @NSManaged public func removeFromDefinitions(_ values: NSSet)

}
