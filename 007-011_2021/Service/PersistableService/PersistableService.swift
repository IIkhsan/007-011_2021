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
        meaningEntity.partOfSpeach = meaning.partOfSpeach
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
    
    func meaningsToSetEntity(meanings: [Meaning]) -> Set<MeaningEntity> {
        var meaningsEntity: Set<MeaningEntity> = []
        for meaning in meanings {
            meaningsEntity.insert(addMeaningEntity(meaning: meaning))
        }
        return meaningsEntity
    }
    
    func phoneticsToSetEntity(phonetics: [Phonetic]) -> Set<PhoneticEntity> {
        var phoneticsEntity: Set<PhoneticEntity> = []
        for phonetic in phonetics {
            phoneticsEntity.insert(addPhoneticEntity(phonetic: phonetic))
        }
        return phoneticsEntity
    }
    
    func definitionsToSetEntity(definitions: [Definition]) -> Set<DefinitionEntity> {
        var definitionsEntity: Set<DefinitionEntity> = []
        for definition in definitions {
            definitionsEntity.insert(addDefinitionEntity(definition: definition))
        }
        return definitionsEntity
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
}
