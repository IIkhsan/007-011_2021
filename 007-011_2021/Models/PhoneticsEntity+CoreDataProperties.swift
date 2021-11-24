//
//  PhoneticsEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//
//

import Foundation
import CoreData


extension PhoneticsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneticsEntity> {
        return NSFetchRequest<PhoneticsEntity>(entityName: "PhoneticsEntity")
    }

    @NSManaged public var text: String
    @NSManaged public var audio: String
    @NSManaged public var word: WordEntity

}

extension PhoneticsEntity : Identifiable {

}
