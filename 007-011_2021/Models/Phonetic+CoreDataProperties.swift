//
//  Phonetic+CoreDataProperties.swift
//  007-011_2021
//
//  Created by Даниил Багаутдинов on 23.11.2021.
//
//

import Foundation
import CoreData


extension Phonetic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Phonetic> {
        return NSFetchRequest<Phonetic>(entityName: "Phonetic")
    }

    @NSManaged public var audio: String?
    @NSManaged public var text: String?
    @NSManaged public var word: Word?

}

extension Phonetic : Identifiable {

}
