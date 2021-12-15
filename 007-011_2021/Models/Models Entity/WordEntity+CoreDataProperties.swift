//
//  WordEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 12.12.2021.
//
//

import Foundation
import CoreData


extension WordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var meaning: String?
    @NSManaged public var phonetic: String?
    @NSManaged public var word: String
    @NSManaged public var meanings: Set<MeaningsEntity>
    @NSManaged public var phonetics: Set<PhoneticsEntity>

}

// MARK: Generated accessors for meanings
extension WordEntity {

    @objc(addMeaningsObject:)
    @NSManaged public func addToMeanings(_ value: MeaningsEntity)

    @objc(removeMeaningsObject:)
    @NSManaged public func removeFromMeanings(_ value: MeaningsEntity)

    @objc(addMeanings:)
    @NSManaged public func addToMeanings(_ values: Set<MeaningsEntity>)

    @objc(removeMeanings:)
    @NSManaged public func removeFromMeanings(_ values: Set<MeaningsEntity>)

}

// MARK: Generated accessors for phonetics
extension WordEntity {

    @objc(addPhoneticsObject:)
    @NSManaged public func addToPhonetics(_ value: PhoneticsEntity)

    @objc(removePhoneticsObject:)
    @NSManaged public func removeFromPhonetics(_ value: PhoneticsEntity)

    @objc(addPhonetics:)
    @NSManaged public func addToPhonetics(_ values: Set<PhoneticsEntity>)

    @objc(removePhonetics:)
    @NSManaged public func removeFromPhonetics(_ values: Set<PhoneticsEntity>)

}

extension WordEntity : Identifiable {

}
