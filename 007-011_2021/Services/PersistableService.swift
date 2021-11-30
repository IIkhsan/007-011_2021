//
//  PersistableService.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 21.11.2021.
//

import Foundation
import UIKit
import CoreData
class PersistableService {
    
    //MARK: - Properties
    static let shared = PersistableService()
    var context: NSManagedObjectContext  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    private init() {
        
    }
    
    //MARK: - Public functions
    func getSavedWord(word: String) -> WordEntity {
        
    }
    
    func deleteSavedWord(wordEntity: WordEntity) {
        
    }
    
    func saveWord(wordEntity: WordEntity) {
        
    }
}
