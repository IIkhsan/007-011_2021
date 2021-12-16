//
//  PhoneticsEntity+CoreDataProperties.swift
//  
//
//  Created by Renat Murtazin on 16.12.2021.
//
//

import Foundation
import CoreData


extension PhoneticsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneticsEntity> {
        return NSFetchRequest<PhoneticsEntity>(entityName: "PhoneticsEntity")
    }

    @NSManaged public var audio: String?
    @NSManaged public var text: String?
    @NSManaged public var word: WordEntity?

}
