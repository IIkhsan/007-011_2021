//
//  MeaningsEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 12.12.2021.
//
//

import Foundation
import CoreData


extension MeaningsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeaningsEntity> {
        return NSFetchRequest<MeaningsEntity>(entityName: "MeaningsEntity")
    }

    @NSManaged public var partOfSpeech: String
    @NSManaged public var definitions: Set<DefinitionsEntity>
    @NSManaged public var word: WordEntity?

}

// MARK: Generated accessors for definitions
extension MeaningsEntity {

    @objc(addDefinitionsObject:)
    @NSManaged public func addToDefinitions(_ value: DefinitionsEntity)

    @objc(removeDefinitionsObject:)
    @NSManaged public func removeFromDefinitions(_ value: DefinitionsEntity)

    @objc(addDefinitions:)
    @NSManaged public func addToDefinitions(_ values: Set<DefinitionsEntity>)

    @objc(removeDefinitions:)
    @NSManaged public func removeFromDefinitions(_ values: Set<DefinitionsEntity>)

}

extension MeaningsEntity : Identifiable {

}
