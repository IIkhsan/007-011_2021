//
//  MeaningEntity+CoreDataClass.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 28.11.2021.
//
//

import Foundation
import CoreData

@objc(MeaningEntity)
public class MeaningEntity: NSManagedObject {

}

extension MeaningEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeaningEntity> {
        return NSFetchRequest<MeaningEntity>(entityName: "MeaningEntity")
    }

    @NSManaged public var partOfSpeech: String?
    @NSManaged public var definitions: Set<DefinitionEntity>?

}

// MARK: Generated accessors for definitions
extension MeaningEntity {

    @objc(addDefinitionsObject:)
    @NSManaged public func addToDefinitions(_ value: DefinitionEntity)

    @objc(removeDefinitionsObject:)
    @NSManaged public func removeFromDefinitions(_ value: DefinitionEntity)

    @objc(addDefinitions:)
    @NSManaged public func addToDefinitions(_ values: NSSet)

    @objc(removeDefinitions:)
    @NSManaged public func removeFromDefinitions(_ values: NSSet)

}

extension MeaningEntity : Identifiable {

}
