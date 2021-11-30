//
//  DefinitionEntity+CoreDataClass.swift
//  
//
//  Created by Роман Сницарюк on 24.11.2021.
//
//

import Foundation
import CoreData

public class DefinitionEntity: NSManagedObject {
  
  convenience init(context: NSManagedObjectContext, _ definition: Definition) {
    self.init(context: context)
    self.definition = definition.definition
    self.example = definition.example
    self.synonyms = definition.synonyms
    self.antonyms = definition.antonyms
  }
}
