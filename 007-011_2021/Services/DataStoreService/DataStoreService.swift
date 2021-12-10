//
//  DataStoreService.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 09.12.2021.
//

import Foundation
import CoreData

class DataStoreService {

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

    // MARK: - CRUD
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo )")
            }
        }
    }
    
    func saveWord(word: Word) {
        let wordEntity = WordEntity(context: viewContext)
        wordEntity.word = word.word
        wordEntity.phonetics = castPhoneticsToSet(phonetics: word.phonetics ?? [])
        wordEntity.meanings = castMeaningsToSet(meanings: word.meanings ?? [])

        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
    }

    func savePhonetic(phonetic: Phonetic) -> PhoneticEntity {
        let phoneticEntity = PhoneticEntity(context: viewContext)
        phoneticEntity.audio = phonetic.audio
        phoneticEntity.text = phonetic.text

        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }

        return phoneticEntity
    }

    func saveMeaning(meaning: Meaning) -> MeaningEntity {
        let meaningEntity = MeaningEntity(context: viewContext)
        meaningEntity.partOfSpeech = meaning.partOfSpeech
        meaningEntity.definitions = castDefinitionsToSet(definitions: meaning.definitions ?? [])

        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }

        return meaningEntity
    }

    func saveDefinition(definition: Definition) -> DefinitionEntity {
        let definitionEntity = DefinitionEntity(context: viewContext)
        definitionEntity.definition = definition.definition
        definitionEntity.example = definition.example

        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }

        return definitionEntity
    }
    
    func castDefinitionsToSet(definitions: [Definition]) -> NSSet {
        var definitionEntities: [DefinitionEntity] = []

        for def in definitions {
            definitionEntities.append(saveDefinition(definition: def))
        }

        return NSSet(array: definitionEntities)
    }

    func castMeaningsToSet(meanings: [Meaning]) -> NSSet {
        var meaningEntities: [MeaningEntity] = []

        for mean in meanings {
            meaningEntities.append(saveMeaning(meaning: mean))
        }

        return NSSet(array: meaningEntities)
    }

    func castPhoneticsToSet(phonetics: [Phonetic]) -> NSSet {
        var phoneticEntities: [PhoneticEntity] = []

        for phon in phonetics {
            phoneticEntities.append(savePhonetic(phonetic: phon))
        }

        return NSSet(array: phoneticEntities)
    }
    
    func getAllWords() -> [WordEntity] {
        let fetchRequest = WordEntity.fetchRequest()
        var wordEntities: [WordEntity] = []
        
        do {
            wordEntities = try viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return wordEntities
    }
    
    func isContainsWord(word: Word) -> Bool {
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
    
    func deleteWord(word: Word) {
        let request = WordEntity.fetchRequest()
        request.predicate = NSPredicate(format: "word == %@", word.word)
        
        do {
            let wordEntities = try viewContext.fetch(request)
            guard let wordEntity = wordEntities.first else { return }
            viewContext.delete(wordEntity)
            
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}
