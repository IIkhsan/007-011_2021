//
//  WordEntity+CoreDataClass.swift
//  
//
//  Created by Роман Сницарюк on 24.11.2021.
//
//

import Foundation
import CoreData


public class WordEntity: NSManagedObject {

  convenience init(context: NSManagedObjectContext, _ word: Word) {
    self.init(context: context)
    self.name = word.name
    self.phonetic = word.phonetic
  }
}
