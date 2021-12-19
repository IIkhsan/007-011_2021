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
    private let userDefaultsIsNotFirstOpeningOfTheApplicationKey = "isNotFirstOpening"
    
    // MARK: - Core Data stack
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "007-011_2021")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy public var context = persistentContainer.viewContext
    
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
        wordEntity.word = word.word
        wordEntity.phonetic = word.phonetic
        wordEntity.origin = word.origin
        let phonetics = self.convertPhoneticsArrayToSet(phonetics: word.phonetics ?? [])
        wordEntity.phonetics = phonetics
        
        let meanings = castMeaningsToSet(word.meanings)
        wordEntity.meanings = meanings
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func convertPhoneticsArrayToSet(phonetics: [Phonetic]) -> NSSet {
        var phoneticsSet: [PhoneticEntity] = []
        for currentPhonetics in phonetics {
            let temporaryPhonetics = savePhonetics(phonetics: currentPhonetics)
            phoneticsSet.append(temporaryPhonetics)
        }
        return NSSet(array: phoneticsSet)
    }
    
    func savePhonetics(phonetics: Phonetic) -> PhoneticEntity {
        let phoneticsEntity = PhoneticEntity(context: context)
        phoneticsEntity.audio = phonetics.audio
        phoneticsEntity.text = phonetics.text
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
        return phoneticsEntity
    }
    
    func saveMeaning(_ meaning: Meaning) -> MeaningEntity {
        let meaningEntity = MeaningEntity(context: context)
        meaningEntity.partOfSpeech = meaning.partOfSpeech
        meaningEntity.definitions = castDefinitionsToSet(meaning.definitions) as NSSet?
        
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
    
    func castDefinitionsToSet(_ definitions: [Definition]?) -> NSSet? {
        return castObjectToSet(definitions, action: saveDefinition)
    }
    
    func castMeaningsToSet(_ meanings: [Meaning]?) -> NSSet? {
        return castObjectToSet(meanings, action: saveMeaning)
    }

    
    private func castObjectToSet<T,U>(_ array: [T]?, action: ((T) -> (U))) -> NSSet? {
        var entities: [U] = []
        
        guard let phonetics = array else {
            return NSSet(array: entities)
        }
        
        for phonetic in phonetics {
            entities.append(action(phonetic))
        }
        let set = NSSet(array: entities)
        return set
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
    
    func isFirstOpeningOfTheApplication() -> Bool {
        let userDefaults = UserDefaults.standard
        let key = userDefaultsIsNotFirstOpeningOfTheApplicationKey
        let isNotFirstOpening = userDefaults.bool(forKey: key)
        if !isNotFirstOpening {
            userDefaults.set(true, forKey: key)
        }
        return !isNotFirstOpening
    }
}
