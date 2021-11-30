//
//  DefinitionEntity+CoreDataProperties.swift
//  
//
//  Created by Роман Сницарюк on 24.11.2021.
//
//

import Foundation
import CoreData


extension DefinitionEntity {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionEntity> {
    return NSFetchRequest<DefinitionEntity>(entityName: "DefinitionEntity")
  }
  
  @NSManaged public var antonyms: [String]
  @NSManaged public var definition: String
  @NSManaged public var example: String?
  @NSManaged public var synonyms: [String]
  @NSManaged public var meaning: MeaningEntity?
  
}
