//
//  MeaningEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Marat Giniyatov on 12.12.2021.
//
//

import Foundation
import CoreData


extension MeaningEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeaningEntity> {
        return NSFetchRequest<MeaningEntity>(entityName: "MeaningEntity")
    }

    @NSManaged public var partOfSpeech: String
    @NSManaged public var word: WordEntity?
    @NSManaged public var definitions: NSSet

}

extension MeaningEntity : Identifiable {

}
