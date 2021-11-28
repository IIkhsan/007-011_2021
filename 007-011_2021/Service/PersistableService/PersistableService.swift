//
//  PersistableService.swift
//  007-011_2021
//
//  Created by Даниил Багаутдинов on 22.11.2021.
//

import Foundation
import CoreData

final class PersistableService {
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "007-011_2021")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support

    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data add new entity
    
    func addWordEntity(word: Word) {
        let wordEntity = WordEntity(context: viewContext)
        wordEntity.word = word.word
        wordEntity.meanings =  meaningsToSetEntity(meanings: word.meanings)
        wordEntity.phonetics = phoneticsToSetEntity(phonetics: word.phonetics)
        
        saveContext()
    }
    
    func addMeaningEntity(meaning: Meaning) -> MeaningEntity {
        let meaningEntity = MeaningEntity(context: viewContext)
        meaningEntity.partOfSpeach = meaning.partOfSpeech
        meaningEntity.definitions = definitionsToSetEntity(definitions: meaning.definitions)
        
        saveContext()
        return meaningEntity
    }
    
    func addPhoneticEntity(phonetic: Phonetic) -> PhoneticEntity {
        let phoneticEntity = PhoneticEntity(context: viewContext)
        phoneticEntity.audio = phonetic.audio
        phoneticEntity.text = phonetic.text
        
        saveContext()
        return phoneticEntity
    }
    
    func addDefinitionEntity(definition: Definition) -> DefinitionEntity {
        let definitionEntity = DefinitionEntity(context: viewContext)
        definitionEntity.definition = definition.definition
        definitionEntity.example = definition.example
        
        saveContext()
        return definitionEntity
    }
    
    // MARK: - Transformation to entity
    
    func meaningsToSetEntity(meanings: [Meaning]) -> NSSet {
        var meaningsEntity: [MeaningEntity] = []
        for meaning in meanings {
            meaningsEntity.append(addMeaningEntity(meaning: meaning))
        }
        
        return NSSet(array: meaningsEntity)
    }
    
    func phoneticsToSetEntity(phonetics: [Phonetic]) -> NSSet {
        var phoneticsEntity: [PhoneticEntity] = []
        for phonetic in phonetics {
            phoneticsEntity.append(addPhoneticEntity(phonetic: phonetic))
        }
        return NSSet(array: phoneticsEntity)
    }
    
    func definitionsToSetEntity(definitions: [Definition]) -> NSSet {
        var definitionsEntity: [DefinitionEntity] = []
        for definition in definitions {
            definitionsEntity.append(addDefinitionEntity(definition: definition))
        }
        return NSSet(array: definitionsEntity)
    }
    
    // MARK: - Core data remove entity
    
    func removeWordEntity(word: Word) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@", word.word)
        
        do {
            let wordsEntity = try viewContext.fetch(fetchRequest)
            guard let wordEntity = wordsEntity.first else { return }
            viewContext.delete(wordEntity)
            saveContext()
        } catch {
            print(error)
        }
    }
    
    func isTrue(word: Word) -> Bool{
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@", word.word)
        do {
            let wordsEntity = try viewContext.fetch(fetchRequest)
            if(wordsEntity.isEmpty) {
                return false
            } else {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
}
