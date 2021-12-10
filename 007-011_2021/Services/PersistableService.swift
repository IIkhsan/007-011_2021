//
//  LocalDataManager.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 07.12.2021.
//

import Foundation
import CoreData

class PersistableService {
    //MARK: - Singleton
    static let shared = PersistableService()
    
    //MARK: - LocalDataManager properties
    let userDefaults = UserDefaults.standard
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WordsData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext = persistentContainer.viewContext
    
    //MARK: - UserDefaults methods
    func setOnboarded() {
        userDefaults.setValue(true, forKey: "isOnboarded")
    }
    
    func isOnboarded() -> Bool {
        return userDefaults.bool(forKey: "isOnboarded")
    }
    
    
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
    
    //MARK: - CRUD CoreData
    /// Saving word in core data
    /// - Parameter word: word to save
    func saveWord(word: WordResponseModel) {
        let wordEntity = WordEntity(context: viewContext)
        wordEntity.word = word.word
        
        word.phonetics.forEach { phonetic in
            let phoneticEntity = PhoneticEntity(context: viewContext)
            phoneticEntity.word = wordEntity
            phoneticEntity.text = phonetic.text
            phoneticEntity.audio = phonetic.audio
            wordEntity.addToPhonetics(phoneticEntity)
        }
        
        word.meanings.forEach { meaning in
            let meaningEntity = MeaningEntity(context: viewContext)
            meaningEntity.word = wordEntity
            meaningEntity.partOfSpeech = meaning.partOfSpeech
            meaning.definitions.forEach { definition in
                let definitionEntity = DefinitionEntity(context: viewContext)
                definitionEntity.definition = definition.definition
                definitionEntity.meanings = meaningEntity
                definitionEntity.example = definition.example
                meaningEntity.addToDefinitions(definitionEntity)
            }
            wordEntity.addToMeanings(meaningEntity)
        }
        saveContext()
    }
    
    /// Fetch all words from core data
    /// - Returns: words array
    func fetchAllWords() -> [WordResponseModel] {
        let fetchRequest = WordEntity.fetchRequest()
        var words: [WordResponseModel] = []
        do {
            let wordsEntity = try viewContext.fetch(fetchRequest)
            wordsEntity.forEach { wordEntity in
                words.append(convertToWord(wordEntity))
            }
        } catch {
            print(error)
        }
        return words
    }
    
    /// Delete word from core data
    /// - Parameter word: word to delete
    func removeWord(word: String) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@", word)
        
        do {
            let words: [WordEntity] = try viewContext.fetch(fetchRequest)
            if !words.isEmpty {
                viewContext.delete(words[0])
                saveContext()
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: - Private methods
    /// Convert word from WordEntity to WordResponseModel
    /// - Parameter wordEntity: wordEntity to convert
    /// - Returns: converted WordResponseModel
    private func convertToWord(_ wordEntity: WordEntity) -> WordResponseModel {
        let word = wordEntity.word
        var phonetics: [PhoneticsResponseModel] = []
        var meanings: [MeaningsResponseModel] = []
        wordEntity.phonetics?.forEach({ phoneticEntity in
            let audio = phoneticEntity.audio
            let text = phoneticEntity.text
            phonetics.append(PhoneticsResponseModel(text: text, audio: audio))
        })
        wordEntity.meanings?.forEach({ meaningEntity in
            let partOfSpeech = meaningEntity.partOfSpeech
            var definitions: [DefinitionsResponseModel] = []
            meaningEntity.definitions?.forEach({ definitionEntity in
                let definition = definitionEntity.definition
                let example = definitionEntity.example
                definitions.append(DefinitionsResponseModel(definition: definition ?? "None", example: example))
            })
            meanings.append(MeaningsResponseModel(partOfSpeech: partOfSpeech, definitions: definitions))
        })
        return WordResponseModel(word: word ?? "None", phonetics: phonetics, meanings: meanings)
    }
}
