//
//  DbService.swift
//  007-011_2021
//
//  Created by Evans Owamoyo on 12.12.2021.
//

import Foundation
import CoreData

class PersistableService {
    // To make sure we have just one instance of container
    static let shared = PersistableService()
    
    private init() {}
    
    // MARK: Core Data
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DictionaryModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy private var viewContext = persistentContainer.viewContext
    
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: CRUD functions
    func fetchWords(startsWith beginning: String? = nil) -> [Word] {
        let request = WordEntity.fetchRequest()
        if let beginning = beginning {
            request.predicate = NSPredicate(format: "word LIKE[c] %@", "*\(beginning)*")
        }
        if let wordEntities = try? viewContext.fetch(request) {
            return wordEntities.map { $0.toWord() }
        } else {
            return []
        }
    }
    
    func fetchWordExact(_ word: String) -> WordEntity? {
        let request = WordEntity.fetchRequest()
        request.predicate = NSPredicate(format: "word == %@", word)
        return (try? viewContext.fetch(request))?.first
    }
    
    func addWord(word: Word) {
        
        // check if word already exists
        if fetchWordExact(word.word) != nil {
            return
        }
        
        let wordEntity = WordEntity(context: viewContext)
        wordEntity.word = word.word
        wordEntity.phonetic = word.phonetic
        wordEntity.origin = word.origin
        
        word.phonetics.forEach { phonetic in
            let phoneticsEntity = PhoneticEntity(context: viewContext)
            phoneticsEntity.text = phonetic.text
            phoneticsEntity.audio = phonetic.audio
            wordEntity.addToPhonetics(phoneticsEntity)
        }
        
        word.meanings.forEach { meaning in
            let meaningEntity = MeaningEntity(context: viewContext)
            meaningEntity.partOfSpeech = meaning.partOfSpeech
            
            meaning.definitions.forEach { definition in
                let definitionEntity = DefinitionEntity(context: viewContext)
                definitionEntity.definition = definition.definition
                definitionEntity.example = definition.example
                
                definition.synonyms.forEach { synonym in
                    let synonymEntity = SynonymEntity(context: viewContext)
                    synonymEntity.value = synonym
                    definitionEntity.addToSynonyms(synonymEntity)
                }
                
                definition.antonyms.forEach { antonym in
                    let antonymEntity = AntonymEntity(context: viewContext)
                    antonymEntity.value = antonym
                    definitionEntity.addToAntonyms(antonymEntity)
                }
                
                meaningEntity.addToDefinitions(definitionEntity)
            }
            
            wordEntity.addToMeanings(meaningEntity)
        }
        
        saveContext()
    }
    
    func deleteWord(word: String) -> Bool {
        let request = WordEntity.fetchRequest()
        request.predicate = NSPredicate(format: "word == %@", word)
        do {
            let word = try viewContext.fetch(request)
            if word.count > 0 {
                viewContext.delete(word[0])
                saveContext()
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
