//
//  CDWord+CoreDataProperties.swift
//  
//
//  Created by Тимур Миргалиев on 11.12.2021.
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

// MARK: Generated accessors for meanings
extension CDWord {

    @objc(addMeaningsObject:)
    @NSManaged public func addToMeanings(_ value: CDMeanings)

    @objc(removeMeaningsObject:)
    @NSManaged public func removeFromMeanings(_ value: CDMeanings)

    @objc(addMeanings:)
    @NSManaged public func addToMeanings(_ values: NSSet)

    @objc(removeMeanings:)
    @NSManaged public func removeFromMeanings(_ values: NSSet)

}

// MARK: Generated accessors for phonetics
extension CDWord {

    @objc(addPhoneticsObject:)
    @NSManaged public func addToPhonetics(_ value: CDPhonetics)

    @objc(removePhoneticsObject:)
    @NSManaged public func removeFromPhonetics(_ value: CDPhonetics)

    @objc(addPhonetics:)
    @NSManaged public func addToPhonetics(_ values: NSSet)

    @objc(removePhonetics:)
    @NSManaged public func removeFromPhonetics(_ values: NSSet)

}
