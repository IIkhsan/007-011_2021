//
//  PersistableService.swift
//  007-011_2021
//
//  Created by Рустем on 14.12.2021.
//

import Foundation
import CoreData
import UIKit

class PersistableService {
    
    // MARK: - Properties
    
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let shared = PersistableService()
    
    // MARK: - Lifecycle
    
    private init() {
    }
    
    // MARK: - Functions
    
    func makeAnEntity(word: Word) -> WordEntity {
        let wordEntity = WordEntity(context: viewContext)
        wordEntity.word = word.word
        wordEntity.origin = word.origin
        for meaning in word.meanings {
            let meaningEntity = MeaningEntity(context: viewContext)
            meaningEntity.partOfSpeech = meaning.partOfSpeech
            for definition in meaning.definitions {
                let definitionEntity = DefinitionEntity(context: viewContext)
                definitionEntity.definition = definition.definition
                definitionEntity.example = definition.example
                if let synonyms = definition.synonyms {
                    for synonym in synonyms {
                        let synonymEntity = SynonymEntity(context: viewContext)
                        synonymEntity.synonym = synonym
                        definitionEntity.addToSynonyms(synonymEntity)
                    }
                }
                if let antonyms = definition.antonyms {
                    for antotnym in antonyms {
                        let antonymEntity = AntonymEntity(context: viewContext)
                        antonymEntity.antonym = antotnym
                        definitionEntity.addToAntonyms(antonymEntity)
                    }
                }
                meaningEntity.addToDefinitions(definitionEntity)
            }
            wordEntity.addToMeanings(meaningEntity)
        }
        if let phonetics = word.phonetics {
            for phonetic in phonetics {
                let phoneticEntity = PhoneticEntity(context: viewContext)
                phoneticEntity.audio = phonetic.text
                phoneticEntity.text = phonetic.audio
                wordEntity.addToPhonetics(phoneticEntity)
            }
        }
        
        return wordEntity
    }
    
    func saveWord(word: Word) {
        //TODO: Проверка на то, что слово уже есть в базе
        
        do {
            try makeAnEntity(word: word).managedObjectContext?.save()
        } catch {
            print("Failed saving")
        }
    }
}


