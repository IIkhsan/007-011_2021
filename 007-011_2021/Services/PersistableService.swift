//
//  PersistableService.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 28.11.2021.
//

import Foundation
import CoreData

class PersistableService {
    
    // MARK: - Private Properties
    
    static let shared = PersistableService()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    lazy var mainContext: NSManagedObjectContext = persistentContainer.viewContext
    
    // MARK: - CRUD
    
    func saveContext () {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo )")
            }
        }
    }
    
    func saveWord(_ word: Word) {
        let wordEntity = WordEntity(context: mainContext)
        wordEntity.word = word.word
        wordEntity.phonetic = word.phonetic
        wordEntity.origin = word.origin
        wordEntity.phonetics = castPhoneticsToSet(word.phonetics)
        wordEntity.meanings = castMeaningsToSet(word.meanings)
        
        do {
            try mainContext.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func savePhonetic(_ phonetic: Phonetic) -> PhoneticEntity {
        let phoneticEntity = PhoneticEntity(context: mainContext)
        phoneticEntity.audio = phonetic.audio
        phoneticEntity.text = phonetic.text
        
        do {
            try mainContext.save()
        } catch let error {
            print("Error: \(error)")
        }
        
        return phoneticEntity
    }
    
    func saveMeaning(_ meaning: Meaning) -> MeaningEntity {
        let meaningEntity = MeaningEntity(context: mainContext)
        meaningEntity.partOfSpeech = meaning.partOfSpeech
        meaningEntity.definitions = castDefinitionsToSet(meaning.definitions)
        
        do {
            try mainContext.save()
        } catch let error {
            print("Error: \(error)")
        }
        
        return meaningEntity
    }
    
    func saveDefinition(_ definition: Definition) -> DefinitionEntity {
        let definitionEntity = DefinitionEntity(context: mainContext)
        definitionEntity.definition = definition.definition
        definitionEntity.example = definition.example
        definitionEntity.synonyms = definition.synonyms
        definitionEntity.antonyms = definition.antonyms
        
        do {
            try mainContext.save()
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
    
    func getAllWords() -> [WordEntity] {
        let fetchRequest = WordEntity.fetchRequest()
        var wordEntities: [WordEntity] = []
        
        do {
            wordEntities = try mainContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return wordEntities
    }
    
    func deleteWord(_ word: Word) {
        let request = WordEntity.fetchRequest()
        
        guard let word = word.word else { return }
        
        request.predicate = NSPredicate(format: "word == %@", word)
        
        do {
            let wordEntities = try mainContext.fetch(request)
            guard let wordEntity = wordEntities.first else { return }
            mainContext.delete(wordEntity)
            
            try mainContext.save()
        } catch {
            print(error)
        }
    }
    
    func deleteAllWords() {
        let request = WordEntity.fetchRequest()
        
        do {
            let wordEntities = try mainContext.fetch(request)
            for entity in wordEntities {
                mainContext.delete(entity)
            }
            try mainContext.save()
        } catch {
            print(error)
        }
    }
}
