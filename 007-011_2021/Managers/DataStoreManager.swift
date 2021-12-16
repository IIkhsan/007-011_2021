//
//  DataStoreManager.swift
//  007-011_2021
//
//  Created by Илья Желтиков on 16.12.2021.
//

import Foundation
import CoreData

class DataStoreManager {
    
    static var viewContext = persistentContainer.viewContext
    
    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Dictionary")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: Saving
    func saveContext () {
        let context = DataStoreManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - CD Method
    func addCdWord(word: Word) {
        let cdWord = CDWord(context: DataStoreManager.viewContext)
        cdWord.word = word.word
        cdWord.phonetic = word.phonetic
        cdWord.origin = word.origin
        cdWord.phonetics = transformPhoneticsToSet(phonetics: word.phonetics ?? [])
        cdWord.meanings = transformMeaningsToSet(meanings: word.meanings ?? [])
        saveContext()
    }
    
    func addCdPhonetics(phonetics: Phonetics) -> CDPhonetics {
        let cdPhonetic = CDPhonetics(context: DataStoreManager.viewContext)
        cdPhonetic.audio = phonetics.audio
        cdPhonetic.text = phonetics.text
        saveContext()
        return cdPhonetic
    }
    
    
    func addCdMeanings(meanings: Meanings) -> CDMeanings {
        let cdMeanings = CDMeanings(context: DataStoreManager.viewContext)
        cdMeanings.definitions = transformDefenitionToSet(definitions: meanings.definitions ?? [])
        cdMeanings.partOfSpeech = meanings.partOfSpeech
        saveContext()
        return cdMeanings
    }
    
    func addCdDefinition(defenition: Definitions) -> CDDefinitions {
        let cdDefinition = CDDefinitions(context: DataStoreManager.viewContext)
        cdDefinition.definition = defenition.definition
        cdDefinition.example = defenition.example
        saveContext()
        return cdDefinition
    }
    
    //MARK: - Transformation To Set
    func transformPhoneticsToSet(phonetics: [Phonetics]) -> NSSet {
        var cdPhonetics: [CDPhonetics] = []
        for phonetic in phonetics {
            cdPhonetics.append(addCdPhonetics(phonetics: phonetic))
        }
        return NSSet(array: cdPhonetics)
    }
    
    func transformMeaningsToSet(meanings: [Meanings]) -> NSSet {
        var cdMeanings: [CDMeanings] = []
        for meaning in meanings {
            cdMeanings.append(addCdMeanings(meanings: meaning))
        }
        return NSSet(array: cdMeanings)
    }
    
    func transformDefenitionToSet(definitions: [Definitions]) -> NSSet{
        var cdDefinition: [CDDefinitions] = []
        for defenition in definitions {
            cdDefinition.append(addCdDefinition(defenition: defenition))
        }
        return NSSet(array: cdDefinition)
    }
    
    //MARK: - Transformation to Entites
    func tranformSetToMeanings(cdMeanings: NSSet) -> [Meanings] {
        var meanings: [Meanings] = []
        let meaningsEntity = cdMeanings.allObjects as? [CDMeanings]
        for cdMeaning in meaningsEntity! {
            meanings.append(Meanings(partOfSpeech: cdMeaning.partOfSpeech, definitions: transformSetToDefenitions(cdDefinitions: cdMeaning.definitions!)))
        }
        return meanings
    }
    
    func transformSetToDefenitions(cdDefinitions: NSSet) -> [Definitions] {
        var definitions: [Definitions] = []
        let definitionsEntity = cdDefinitions.allObjects as? [CDDefinitions]
        for cdDefinition in definitionsEntity! {
            definitions.append(Definitions(definition: cdDefinition.definition, example: cdDefinition.example))
        }
        return definitions
    }
    
    func transformSetToPhonetics(cdPhonetics: NSSet) -> [Phonetics] {
        var phonetics: [Phonetics] = []
        let phoneticsEntity = cdPhonetics.allObjects as? [CDPhonetics]
        for cdPhonetic in phoneticsEntity! {
            phonetics.append(Phonetics(text: cdPhonetic.text, audio: cdPhonetic.audio))
        }
        return phonetics
    }
    
    //MARK: - Getting words
    func getAllWords() -> [Word] {
        let fetchRequest = CDWord.fetchRequest()
        var words: [Word] = []
        do {
            let wordsEntity = try DataStoreManager.viewContext.fetch(fetchRequest)
            for wordEntity in wordsEntity {
                words.append(Word(word: wordEntity.word ?? "", phonetic: wordEntity.phonetic, phonetics: transformSetToPhonetics(cdPhonetics: wordEntity.phonetics ?? NSSet()), origin: wordEntity.origin, meanings: tranformSetToMeanings(cdMeanings: wordEntity.meanings ?? NSSet())))
            }
        } catch {
            print(error)
        }
        return words
    }
    
    //MARK: - Checker of word containing
    func isContains(word: Word) -> Bool {
        let fetchRequest = CDWord.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@", word.word)
        do {
            let cdWord = try DataStoreManager.viewContext.fetch(fetchRequest)
            if (cdWord.isEmpty) {
                return false
            } else {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
    //MARK: - Removing word from DB
    func removeWord(word: Word) {
        let fetchRequest = CDWord.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@", word.word)
        do{
            let cdWords = try DataStoreManager.viewContext.fetch(fetchRequest)
            guard let cdWord = cdWords.first else { return }
            DataStoreManager.viewContext.delete(cdWord)
            saveContext()
        } catch {
            print(error)
        }
    }
}
