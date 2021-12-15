//
//  PersistableService.swift
//  007-011_2021
//
//  Created by Marat Giniyatov on 13.12.2021.
//

import Foundation
import CoreData

class PersistableService {
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var viewContext = persistentContainer.viewContext
    
    // MARK: - save context method
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
    // MARK: - delete word method
    func deleteSavedWord(word: Word) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@",word.word)
        do {
            let words = try viewContext.fetch(fetchRequest)
            guard let wordEntity = words.first else { return }
            viewContext.delete(wordEntity)
            saveContext()
            
        } catch {
            print(error)
        }
    }
    // MARK: - save methods
    func saveNewWord(word: Word) {
        let wordEntity = WordEntity(context: viewContext)
        wordEntity.word = word.word
        wordEntity.origin = word.origin
        wordEntity.meanings = setMeanings(meanings: word.meanings)
        wordEntity.phonetics = setPhonetics(phonetics: word.phonetics)
        saveContext()
    }
    func savePhonetic(phonetic: Phonetic ) -> PhoneticEntity {
        let phoneticEntity = PhoneticEntity(context: viewContext)
        phoneticEntity.text = phonetic.text
        phoneticEntity.audio = phonetic.audio
        saveContext()
        return phoneticEntity
    }
    func saveMeaning(meaning: Meaning) -> MeaningEntity {
        let meaningEntity = MeaningEntity(context: viewContext)
        meaningEntity.partOfSpeech = meaning.partOfSpeech
        saveContext()
        return meaningEntity
    }
    func saveDefinition(definition: Definition) -> DefinitionEntity {
        let definitionEntity = DefinitionEntity(context: viewContext)
        definitionEntity.definition = definition.definition
        definitionEntity.example = definition.example
        saveContext()
        return definitionEntity
    }
    
    
    func isExists(word: Word) -> Bool {
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
   
        
    func setMeanings(meanings: [Meaning]) -> NSSet {
    var meaningEntities: [MeaningEntity] = []
        for meaning in meanings {
            meaningEntities.append(saveMeaning(meaning: meaning))
        }
        
        return NSSet(array: meaningEntities)
    }
    func setPhonetics(phonetics: [Phonetic]) -> NSSet {
        var phoneticEntities: [PhoneticEntity] = []
            for phonetic in phonetics {
                phoneticEntities.append(savePhonetic(phonetic: phonetic))
            }
        
        return NSSet(array: phoneticEntities)
    }
    func setDefinitions(definitions: [Definition]) -> NSSet {
        var definitionEntities: [DefinitionEntity] = []
        for definition in definitions {
                definitionEntities.append(saveDefinition(definition: definition))
            }
        return NSSet(array: definitionEntities)
    }
   
    // MARK: - get Words method
    func getSavedWords() -> [Word] {
        let fetchRequest = WordEntity.fetchRequest()
        var savedWords: [Word] = []
        do {
            let words = try viewContext.fetch(fetchRequest)
            for wordEntity in words {
                savedWords.append(
                    Word(word: wordEntity.word ?? "", origin: wordEntity.origin, phonetics: configurePhonetics(phonetics: wordEntity.phonetics), meanings: configureMeanings(meanings: wordEntity.meanings)))
            }
        } catch {
            print(error)
        }
        return savedWords
    }
    
    
    func configurePhonetics(phonetics: NSSet) -> [Phonetic] {
        var phoneticArray: [Phonetic] = []
        let phoneticEntityArray = phonetics.allObjects as? [PhoneticEntity] ?? []
        for entity in phoneticEntityArray {
            phoneticArray.append(Phonetic(text: entity.text ?? "", audio: entity.audio))
        }
        return phoneticArray
    }
    
    func configureMeanings(meanings: NSSet) -> [Meaning] {
        var meaningArray: [Meaning] = []
        let meaningEntityArray = meanings.allObjects as? [MeaningEntity] ?? []
        for entity in meaningEntityArray {
            meaningArray.append(Meaning(partOfSpeech: entity.partOfSpeech , definitions: configureDefenitions(definitions: entity.definitions)))
            
        }
        return meaningArray
    }
    
    func configureDefenitions(definitions: NSSet) -> [Definition] {
        var definitionArray: [Definition] = []
        let definitionEntityArray = definitions.allObjects as? [DefinitionEntity] ?? []
        for entity in definitionEntityArray {
            definitionArray.append(Definition(definition: entity.definition, example: entity.example))
            
        }
        return definitionArray
            }
                                
}
