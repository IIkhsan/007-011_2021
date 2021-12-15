//
//  WordEntity+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Marat Giniyatov on 12.12.2021.
//
//

import Foundation
import CoreData


extension WordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var word: String?
    @NSManaged public var origin: String?
    @NSManaged public var phonetics: NSSet
    @NSManaged public var meanings: NSSet
}

extension WordEntity : Identifiable {

}
