//
//  DefinitionEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Рустем on 16.12.2021.
//
//

import Foundation
import CoreData


extension DefinitionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionEntity> {
        return NSFetchRequest<DefinitionEntity>(entityName: "DefinitionEntity")
    }

    @NSManaged public var definition: String?
    @NSManaged public var example: String?
    @NSManaged public var synonyms: Set<SynonymEntity>?
    @NSManaged public var antonyms: Set<AntonymEntity>?

}

// MARK: Generated accessors for synonyms
extension DefinitionEntity {

    @objc(addSynonymsObject:)
    @NSManaged public func addToSynonyms(_ value: SynonymEntity)

    @objc(removeSynonymsObject:)
    @NSManaged public func removeFromSynonyms(_ value: SynonymEntity)

    @objc(addSynonyms:)
    @NSManaged public func addToSynonyms(_ values: NSSet)

    @objc(removeSynonyms:)
    @NSManaged public func removeFromSynonyms(_ values: NSSet)

}

// MARK: Generated accessors for antonyms
extension DefinitionEntity {

    @objc(addAntonymsObject:)
    @NSManaged public func addToAntonyms(_ value: AntonymEntity)

    @objc(removeAntonymsObject:)
    @NSManaged public func removeFromAntonyms(_ value: AntonymEntity)

    @objc(addAntonyms:)
    @NSManaged public func addToAntonyms(_ values: NSSet)

    @objc(removeAntonyms:)
    @NSManaged public func removeFromAntonyms(_ values: NSSet)

}

extension DefinitionEntity : Identifiable {

}
