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
    lazy public var persistentContainer: NSPersistentContainer = {
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
        let fetchRequest = WordEntity.fetchRequest()
        var wordEntities: [WordEntity] = []
        
        do {
            wordEntities = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return wordEntities
    }
    
    func saveWord(_ word: Word) {
        let wordEntity = WordEntity(context: context)
        wordEntity.word = word.word
        wordEntity.phonetic = word.phonetic
        wordEntity.origin = word.origin
        let phonetics: NSSet = self.convertPhoneticsArrayToSet(phonetics: word.phonetics ?? [])
        wordEntity.addToPhonetics(phonetics)
        
        let meanings = self.convertMeaningsArrayToSet(meanings: word.meanings ?? [])
        wordEntity.addToMeanings(meanings)
        
        do {
            try context.save()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func convertPhoneticsArrayToSet(phonetics: [Phonetic]) -> NSSet {
        var phoneticsSet: [PhoneticEntity] = []
        for currentPhonetics in phonetics {
            let temp = savePhonetics(phonetics: currentPhonetics)
            phoneticsSet.append(temp)
        }
        return NSSet(array: phoneticsSet)
    }
    
    func convertMeaningsArrayToSet(meanings: [Meaning]) -> NSSet {
        var meaningsSet: [MeaningEntity] = []
        for meaning in meanings {
            let temp = saveMeaning(meaning)
            meaningsSet.append(temp)
        }
        return NSSet(array: meaningsSet)
    }
    
    func convertDefinitionsArrayToSet(definitions: [Definition]) -> NSSet {
        var definitionsSet: [DefinitionEntity] = []
        for definition in definitions {
            let temp = saveDefinition(definition)
            definitionsSet.append(temp)
        }
        return NSSet(array: definitionsSet)
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
        meaningEntity.definitions = convertDefinitionsArrayToSet(definitions: meaning.definitions ?? []) as NSSet?
        
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
    
    func isOldUser() -> Bool {
        return UserDefaults.standard.bool(forKey: "isOldUser")
    }
    
    func setIsOldUser() {
        UserDefaults.standard.set(true, forKey: "isOldUser")
    }
}
