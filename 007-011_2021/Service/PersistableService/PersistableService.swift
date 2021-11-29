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
        wordEntity.meanings =  transformMeaningsToSet(meanings: word.meanings)
        wordEntity.phonetics = transformPhoneticsToSet(phonetics: word.phonetics)
        
        saveContext()
    }
    
    func addMeaningEntity(meaning: Meaning) -> MeaningEntity {
        let meaningEntity = MeaningEntity(context: viewContext)
        meaningEntity.partOfSpeach = meaning.partOfSpeech
        meaningEntity.definitions = transformDefinitionsToSet(definitions: meaning.definitions)
        
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
    
    // MARK: - Entity transformation
    
    func transformMeaningsToSet(meanings: [Meaning]) -> NSSet {
        var meaningsEntity: [MeaningEntity] = []
        for meaning in meanings {
            meaningsEntity.append(addMeaningEntity(meaning: meaning))
        }
        
        return NSSet(array: meaningsEntity)
    }
    
    func transformPhoneticsToSet(phonetics: [Phonetic]) -> NSSet {
        var phoneticsEntity: [PhoneticEntity] = []
        for phonetic in phonetics {
            phoneticsEntity.append(addPhoneticEntity(phonetic: phonetic))
        }
        return NSSet(array: phoneticsEntity)
    }
    
    func transformDefinitionsToSet(definitions: [Definition]) -> NSSet {
        var definitionsEntity: [DefinitionEntity] = []
        for definition in definitions {
            definitionsEntity.append(addDefinitionEntity(definition: definition))
        }
        return NSSet(array: definitionsEntity)
    }
    
    func transformSetToPhonetics(phoneticsEntity: NSSet) -> [Phonetic] {
        var phonetics: [Phonetic] = []
        let phoneticsEntity = phoneticsEntity.allObjects as? [PhoneticEntity]
        for phoneticEntity in phoneticsEntity! {
            phonetics.append(Phonetic(text: phoneticEntity.text, audio: phoneticEntity.audio))
        }
        return phonetics
    }
    
    func transformSetToMeanings(meaningsEntity: NSSet) -> [Meaning] {
        var meanings: [Meaning] = []
        let meaningsEntity = meaningsEntity.allObjects as? [MeaningEntity]
        for meaningEntity in meaningsEntity! {
            meanings.append(Meaning(partOfSpeech: meaningEntity.partOfSpeach, definitions: transformSetToDefinitions(definitionsEntity: meaningEntity.definitions)))
        }
        return meanings
    }
    
    func transformSetToDefinitions(definitionsEntity: NSSet) -> [Definition] {
        var definitions: [Definition] = []
        let definitionsEntity = definitionsEntity.allObjects as? [DefinitionEntity]
        for definitionEntity in definitionsEntity! {
            definitions.append(Definition(definition: definitionEntity.definition, example: definitionEntity.example))
        }
        return definitions
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
    
    // MARK: - Supporting methods
    
    func isTrue(word: Word) -> Bool {
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
    
    func getAllWords() -> [Word] {
        let fetchRequest = WordEntity.fetchRequest()
        var words: [Word] = []
        do {
            let wordsEntity = try viewContext.fetch(fetchRequest)
            for wordEntity in wordsEntity {
                words.append(Word(word: wordEntity.word, phonetics: transformSetToPhonetics(phoneticsEntity: wordEntity.phonetics), meanings: transformSetToMeanings(meaningsEntity: wordEntity.meanings)))
            }
        } catch {
            print(error)
        }
        return words
    }
}
