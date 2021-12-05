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
    func getSavedWordsContaining(word: String) -> [WordEntity] {
        let request: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
        request.predicate = NSPredicate(format: "word CONTAINS %@", word)
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print(error)
        }
        return []
    }
    
    func getSavedWord(word: String) -> WordEntity? {
        let request: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
        request.predicate = NSPredicate(format: "word == %@", word)
        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            print(error)
        }
        return nil
    }
    
    func getAllSavedWords() -> [WordEntity] {
        let request: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print(error)
        }
        return []
    }
    
       
    func deleteSavedWord(wordEntity: WordEntity) {
        context.delete(wordEntity)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func saveWord(wordEntity: WordEntity) {
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
    }
}
