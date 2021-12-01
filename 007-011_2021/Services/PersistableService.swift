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
    
    func getPhoneticWith(text: String) -> PhoneticEntity? {
        let request: NSFetchRequest<PhoneticEntity> = PhoneticEntity.fetchRequest()
        request.predicate = NSPredicate(format: "text == %@", text)
        do {
            let result = try context.fetch(request)
            return result.first
        }  catch {
            print(error)
        }
        return nil
    }
    
    func getMeaningEntity(partOfSpeech: String, definitions: [Definition]) -> MeaningEntity? {
        var definitionEntities: [DefinitionEntity] = []
        for definition in definitions {
            let entity = getDefinition(definition: definition.definition)
            if entity != nil {
                definitionEntities.append(entity!)
            }
        }
        let request: NSFetchRequest<MeaningEntity> = MeaningEntity.fetchRequest()
        request.predicate = NSPredicate(format: "(partOfSpeech == %@) AND (definitions IN %@) AND (%@ in definitions)", partOfSpeech, definitionEntities, definitionEntities)
        do {
            let result = try context.fetch(request)
            return result.first
        }  catch {
            print(error)
        }
        return nil
    }
    
    func getDefinition(definition: String) -> DefinitionEntity? {
        let request: NSFetchRequest<DefinitionEntity> = DefinitionEntity.fetchRequest()
        request.predicate = NSPredicate(format: "definition == %@", definition)
        do {
            let result = try context.fetch(request)
            return result.first
        }  catch {
            print(error)
        }
        return nil
    }
    
    func getAntonym(antonym: String) -> AntonymEntity? {
        let request: NSFetchRequest<AntonymEntity> = AntonymEntity.fetchRequest()
        request.predicate = NSPredicate(format: "antonym == %@", antonym)
        do {
            let result = try context.fetch(request)
            return result.first
        }  catch {
            print(error)
        }
        return nil
    }
    
    func getSynonym(synonym: String) -> SynonymEntity? {
        let request: NSFetchRequest<SynonymEntity> = SynonymEntity.fetchRequest()
        request.predicate = NSPredicate(format: "synonym == %@", synonym)
        do {
            let result = try context.fetch(request)
            return result.first
        }  catch {
            print(error)
        }
        return nil
    }
    
    func deleteSavedWord(wordEntity: WordEntity) {
        context.delete(wordEntity)
    }
    
    func saveWord(wordEntity: WordEntity) {
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
    }
}
