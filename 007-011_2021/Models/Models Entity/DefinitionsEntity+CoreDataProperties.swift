//
//  DefinitionsEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 12.12.2021.
//
//

import Foundation
import CoreData


extension DefinitionsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionsEntity> {
        return NSFetchRequest<DefinitionsEntity>(entityName: "DefinitionsEntity")
    }

    @NSManaged public var definition: String?
    @NSManaged public var example: String?
    @NSManaged public var antonyms: Set<AntonymsEntity>
    @NSManaged public var meanings: MeaningsEntity?
    @NSManaged public var synonyms: Set<SynonymsEntity>

}

// MARK: Generated accessors for antonyms
extension DefinitionsEntity {

    @objc(addAntonymsObject:)
    @NSManaged public func addToAntonyms(_ value: AntonymsEntity)

    @objc(removeAntonymsObject:)
    @NSManaged public func removeFromAntonyms(_ value: AntonymsEntity)

    @objc(addAntonyms:)
    @NSManaged public func addToAntonyms(_ values: Set<AntonymsEntity>)

    @objc(removeAntonyms:)
    @NSManaged public func removeFromAntonyms(_ values: Set<AntonymsEntity>)

}

// MARK: Generated accessors for synonyms
extension DefinitionsEntity {

    @objc(addSynonymsObject:)
    @NSManaged public func addToSynonyms(_ value: SynonymsEntity)

    @objc(removeSynonymsObject:)
    @NSManaged public func removeFromSynonyms(_ value: SynonymsEntity)

    @objc(addSynonyms:)
    @NSManaged public func addToSynonyms(_ values: Set<SynonymsEntity>)

    @objc(removeSynonyms:)
    @NSManaged public func removeFromSynonyms(_ values: Set<SynonymsEntity>)

}

extension DefinitionsEntity : Identifiable {

}
