//
//  PersistableService.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import Foundation
import UIKit
import CoreData
class PersistableService {
    
    //MARK: - Properties
    static let shared = PersistableService()
    
    
    var context: NSManagedObjectContext  {
        let container = NSPersistentContainer(name: "007-011_2021")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        let context = container.viewContext
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
    
    func saveWord(_ word: Word) {
        let wordEntity = WordEntity(context: context)
        wordEntity.word = word.word ?? ""
        wordEntity.phonetic = word.phonetic
        wordEntity.origin = word.origin
        wordEntity.phonetics = castPhoneticsToSet(word.phonetics)
        wordEntity.meanings = castMeaningsToSet(word.meanings)
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func savePhonetic(_ phonetic: Phonetic) -> PhoneticEntity {
        let phoneticEntity = PhoneticEntity(context: context)
        phoneticEntity.audio = phonetic.audio
        phoneticEntity.text = phonetic.text
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
        
        return phoneticEntity
    }
    
    func saveMeaning(_ meaning: Meaning) -> MeaningEntity {
        let meaningEntity = MeaningEntity(context: context)
        meaningEntity.partOfSpeech = meaning.partOfSpeech
        meaningEntity.definitions = castDefinitionsToSet(meaning.definitions) as NSSet
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
        
        return meaningEntity
    }
    
    func saveDefinition(_ definition: Definition) -> DefinitionEntity {
        let definitionEntity = DefinitionEntity(context: context)
        definitionEntity.definition = definition.definition
        definitionEntity.example = definition.example
        definitionEntity.synonyms = definition.synonyms
        definitionEntity.antonyms = definition.antonyms
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
        
        return definitionEntity
    }
    
    func castDefinitionsToSet(_ definitions: [Definition]?) -> NSSet {
        return castObjectToSet(definitions, action: saveDefinition)
    }
    
    func castMeaningsToSet(_ meanings: [Meaning]?) -> NSSet {
        return castObjectToSet(meanings, action: saveMeaning)
    }
    
    func castPhoneticsToSet(_ phonetics: [Phonetic]?) -> NSSet {
        return castObjectToSet(phonetics, action: savePhonetic)
    }
    
    private func castObjectToSet<T,U>(_ array: [T]?, action: ((T) -> (U))) -> NSSet {
        var entities: [U] = []
        
        guard let phonetics = array else {
            return NSSet(array: entities)
        }
        
        for phonetic in phonetics {
            entities.append(action(phonetic))
        }
        
        return NSSet(array: entities)
    }
    
    
    func deleteWord(_ word: Word) {
        let request = WordEntity.fetchRequest()
        
        request.predicate = NSPredicate(format: "word == %@", word.word)
        
        do {
            let wordEntities = try context.fetch(request)
            guard let wordEntity = wordEntities.first else { return }
            context.delete(wordEntity)
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
}
