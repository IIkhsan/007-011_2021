//
//  MeaningEntity+CoreDataClass.swift
//  
//
//  Created by Роман Сницарюк on 24.11.2021.
//
//

import Foundation
import CoreData


public class MeaningEntity: NSManagedObject {

  convenience init(context: NSManagedObjectContext, _ meaning: Meaning) {
    self.init(context: context)
    self.partOfSpeach = meaning.partOfSpeech
  }
}
