//
//  Word+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Семен Соколов on 24.11.2021.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var word: String
    @NSManaged public var phonetics: NSSet?
    @NSManaged public var meanings: NSSet?

}

// MARK: Generated accessors for phonetics
extension Word {

    @objc(addPhoneticsObject:)
    @NSManaged public func addToPhonetics(_ value: Phonetic)

    @objc(removePhoneticsObject:)
    @NSManaged public func removeFromPhonetics(_ value: Phonetic)

    @objc(addPhonetics:)
    @NSManaged public func addToPhonetics(_ values: NSSet)

    @objc(removePhonetics:)
    @NSManaged public func removeFromPhonetics(_ values: NSSet)

}

// MARK: Generated accessors for meanings
extension Word {

    @objc(addMeaningsObject:)
    @NSManaged public func addToMeanings(_ value: Meaning)

    @objc(removeMeaningsObject:)
    @NSManaged public func removeFromMeanings(_ value: Meaning)

    @objc(addMeanings:)
    @NSManaged public func addToMeanings(_ values: NSSet)

    @objc(removeMeanings:)
    @NSManaged public func removeFromMeanings(_ values: NSSet)

}

extension Word : Identifiable {

}
