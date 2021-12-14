//
//  Meaning+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Семен Соколов on 24.11.2021.
//
//

import Foundation
import CoreData


extension Meaning {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meaning> {
        return NSFetchRequest<Meaning>(entityName: "Meaning")
    }

    @NSManaged public var partOfSpeach: String?
    @NSManaged public var word: Word?
    @NSManaged public var definitions: NSSet?

}

// MARK: Generated accessors for definitions
extension Meaning {

    @objc(addDefinitionsObject:)
    @NSManaged public func addToDefinitions(_ value: Definition)

    @objc(removeDefinitionsObject:)
    @NSManaged public func removeFromDefinitions(_ value: Definition)

    @objc(addDefinitions:)
    @NSManaged public func addToDefinitions(_ values: NSSet)

    @objc(removeDefinitions:)
    @NSManaged public func removeFromDefinitions(_ values: NSSet)

}

extension Meaning : Identifiable {

}
