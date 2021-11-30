//
//  PhoneticEntity+CoreDataClass.swift
//  
//
//  Created by Роман Сницарюк on 24.11.2021.
//
//

import Foundation
import CoreData


public class PhoneticEntity: NSManagedObject {

  convenience init(context: NSManagedObjectContext, _ phonetic: Phonetic) {
    self.init(context: context)
    self.name = phonetic.text
    self.audio = phonetic.audio
  }
}
