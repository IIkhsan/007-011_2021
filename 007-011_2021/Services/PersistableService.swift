//
//  PersistableService.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 23.11.2021.
//

import Foundation
import CoreData

final class PersistableService {
    
    //MARK: - Dependencies
    let userDefaults = UserDefaults.standard
    static let shared = PersistableService()
    lazy var viewContext = persistentContainer.viewContext
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveWord() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Functions
    func saveWordEntity(_ word: Word) {
        let wordEntity = WordEntity(context: viewContext)
        wordEntity.word = word.word
        
        word.meanings.forEach { meaning in
            let meaningsEntity = MeaningsEntity(context: viewContext)
            meaningsEntity.partOfSpeech = meaning.partOfSpeech
            
            meaning.definitions.forEach { definition in
                let definitionsEntity = DefinitionsEntity(context: viewContext)
                definitionsEntity.definition = definition.definition
                definitionsEntity.meanings = meaningsEntity
                definitionsEntity.example = definition.example
                
                definition.synonyms.forEach { synonym in
                    let synonymsEntity = SynonymsEntity(context: viewContext)
                    synonymsEntity.synonymValue = synonym
                    definitionsEntity.addToSynonyms(synonymsEntity)
                }
                
                definition.antonyms.forEach { antonym in
                    let antonymsEntity = AntonymsEntity(context: viewContext)
                    antonymsEntity.antonymValue = antonym
                    definitionsEntity.addToAntonyms(antonymsEntity)
                }
                
                meaningsEntity.addToDefinitions(definitionsEntity)
            }
            wordEntity.addToMeanings(meaningsEntity)
        }
        
        word.phonetics.forEach{ phonetic in
            let phoneticsEntity = PhoneticsEntity(context: viewContext)
            phoneticsEntity.text = phonetic.text
            phoneticsEntity.audio = phonetic.audio
            wordEntity.addToPhonetics(phoneticsEntity)
        }
        saveWord()
    }
    
    func fetchWords() -> [Word] {
        let fetchRequest = WordEntity.fetchRequest()
        var words: [Word] = []
        do{
            let wordEntity = try viewContext.fetch(fetchRequest)
            wordEntity.forEach { wordEntity in
                words.append(convertToWord(from: wordEntity))
            }
        } catch {
            print(error)
        }
        return words
    }
    
    func deleteWord(word: String) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@", word)
        do {
            let words: [WordEntity] = try viewContext.fetch(fetchRequest)
            if !words.isEmpty {
                viewContext.delete(words[0])
                saveWord()
            }
        } catch {
            print(error)
        }
    }
    
    // - Private functions
    private func convertToWord(from wordEntity: WordEntity) -> Word {
        let word = wordEntity.word
        let phonetic = wordEntity.phonetic
        let phonetics: [Phonetics] = wordEntity.phonetics.map { phoneticsEntity in
            return Phonetics(audio: phoneticsEntity.audio, text: phoneticsEntity.text)
        }
        let meaning = wordEntity.meaning
        let meanings: [Meanings] = wordEntity.meanings.map { meaningEntity in
            
            let partOfSpeech = meaningEntity.partOfSpeech
            let definitions: [Definitions] = meaningEntity.definitions.map { definitionEntity in
                
                let definition = definitionEntity.definition
                let example = definitionEntity.example
                let synonyms = definitionEntity.synonyms.map { synonymsEntity in
                    return synonymsEntity.synonymValue
                }
                let antonyms = definitionEntity.antonyms.map { antonymEntity in
                    return antonymEntity.antonymValue
                }
                return Definitions(definition: definition, example: example,
                                   synonyms: synonyms, antonyms: antonyms)
            }
            return Meanings(partOfSpeech: partOfSpeech, definitions: definitions)
        }
        return Word(word: word, phonetic: phonetic, meaning: meaning, phonetics: phonetics, meanings: meanings)
    }
}

