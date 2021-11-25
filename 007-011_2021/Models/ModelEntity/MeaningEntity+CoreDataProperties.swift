//
//  MeaningEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Даниил Багаутдинов on 23.11.2021.
//
//

import Foundation
import CoreData


extension MeaningEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeaningEntity> {
        return NSFetchRequest<MeaningEntity>(entityName: "MeaningEntity")
    }

    @NSManaged public var partOfSpeach: String
    @NSManaged public var definitions: Set<DefinitionEntity>
    @NSManaged public var word: WordEntity

}

extension MeaningEntity : Identifiable {

}
