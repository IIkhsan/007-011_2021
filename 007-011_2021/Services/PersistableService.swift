//
//  PersistableService.swift
//  007-011_2021
//
//  Created by Семен Соколов on 24.11.2021.
//

import Foundation
import UIKit
import CoreData

final class PersistableService {
    
    //MARK: - Core Data Saving support
    lazy var context = persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "007-011_2021")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Functions to add entities to core data
    func addWordToCoreData(word: Word) {
        let wordEntity = WordEntity(context: context)
        wordEntity.word = word.word
        wordEntity.phonetics = convertPhoneticToSet(phonetics: word.phonetics)
        wordEntity.meanings = convertMeaningToSet(meanings: word.meanings)
        saveContext()
    }
    
    func addMeaningToCoreData(meaning: Meaning) -> MeaningEntity {
        let meaningEntity = MeaningEntity(context: context)
        meaningEntity.definitions = convertDefinitionToSet(definitions: meaning.definitions)
        saveContext()
        return meaningEntity
    }
    
    func addPhoneticToCoreData(phonetic: Phonetic) -> PhoneticEntity {
        let phoneticEntity = PhoneticEntity(context: context)
        phoneticEntity.audio = phonetic.audio
        phoneticEntity.text = phonetic.text
        saveContext()
        return phoneticEntity
    }
    
    func addDefinitionToCoreData(definition: Definition) -> DefinitionEntity {
        let definitionEntity = DefinitionEntity(context: context)
        definitionEntity.definition = definition.definition
        definitionEntity.example = definition.example
        saveContext()
        return definitionEntity
    }
    
    //MARK: - Functions to convert structs to Entities
    func convertPhoneticToSet(phonetics: [Phonetic]) -> NSSet {
        var phoneticsEntity: [PhoneticEntity] = []
        for phonetic in phonetics {
            phoneticsEntity.append(addPhoneticToCoreData(phonetic: phonetic))
        }
        return NSSet(array: phoneticsEntity)
    }
    
    func convertMeaningToSet(meanings: [Meaning]) -> NSSet {
        var meaningsEntity: [MeaningEntity] = []
        for meaning in meanings {
            meaningsEntity.append(addMeaningToCoreData(meaning: meaning))
        }
        return NSSet(array: meaningsEntity)
    }
    
    func convertDefinitionToSet(definitions: [Definition]) -> NSSet {
        var definitionsEntity: [DefinitionEntity] = []
        for definition in definitions {
            definitionsEntity.append(addDefinitionToCoreData(definition: definition))
        }
        return NSSet(array: definitionsEntity)
    }
    
    //MARK: - Functions to convert entities to structs
    func convertSetToPhonetics(phoneticsEntity: NSSet) -> [Phonetic] {
        var phonetics: [Phonetic] = []
        let phoneticsEntity = phoneticsEntity.allObjects as? [PhoneticEntity]
        for phoneticEntity in phoneticsEntity! {
            phonetics.append(Phonetic(text: phoneticEntity.text, audio: phoneticEntity.audio))
        }
        return phonetics
    }
    
    func convertSetToMeanings(meaningsEntity: NSSet) -> [Meaning] {
        var meanings: [Meaning] = []
        let meaningsEntity = meaningsEntity.allObjects as? [MeaningEntity]
        for meaningEntity in meaningsEntity! {
            meanings.append(Meaning(partOfSpeech: meaningEntity.partOfSpeach ?? "", definitions: convertSetToDefinitions(definitionsEntity: meaningEntity.definitions)))
        }
        return meanings
    }
    
    func convertSetToDefinitions(definitionsEntity: NSSet) -> [Definition] {
        var definitions: [Definition] = []
        let definitionsEntity = definitionsEntity.allObjects as? [DefinitionEntity]
        for definitionEntity in definitionsEntity! {
            definitions.append(Definition(definition: definitionEntity.definition, example: definitionEntity.example))
        }
        return definitions
    }
    
    //MARK: - Function to delete word from coreData
    func removeWordEntity(word: Word) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@", word.word)
        
        do {
            let wordsEntity = try context.fetch(fetchRequest)
            guard let wordEntity = wordsEntity.first else { return }
            context.delete(wordEntity)
            saveContext()
        } catch {
            print(error)
        }
    }
    
    //MARK: - fucntion to get all words from core data
    func getAllWords() -> [Word] {
        let fetchRequest = WordEntity.fetchRequest()
        var words: [Word] = []
        do {
            let wordsEntity = try context.fetch(fetchRequest)
            for wordEntity in wordsEntity {
                words.append(Word(word: wordEntity.word, phonetics: convertSetToPhonetics(phoneticsEntity: wordEntity.phonetics), meanings: convertSetToMeanings(meaningsEntity: wordEntity.meanings)))
            }
        } catch {
            print(error)
        }
        return words
    }
}
