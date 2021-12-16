//
//  InteractorService.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 12.12.2021.
//

import Foundation

class WordInteractorService {
    // MARK: - Properties
    
    static let shared = WordInteractorService()

    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Public functions
    
    func getSavedWords() -> [Word] {
        let wordEntities = PersistableService.shared.getAllWords()
        var words = [Word]()
        
        for wordEntity in wordEntities {
            let word = Word(word: wordEntity.word, phonetic: wordEntity.phonetic, phonetics: castPhoneticsSetToArray(phoneticEntitiesSet: wordEntity.phonetics ?? []), origin: wordEntity.origin, meanings: castMeaningsSetToArray(meaningEntitiesSet: wordEntity.meanings ?? []))
            words.append(word)
        }
        return words
    }
    
    func save(word: Word) {
        PersistableService.shared.saveWord(word)
    }
    
    func delete(word: Word) {
        PersistableService.shared.deleteWord(word)
    }
    
    func clear() {
        PersistableService.shared.deleteAllWords()
    }
    
    // MARK: - Private functions
    
    private func castMeaningsSetToArray(meaningEntitiesSet: NSSet) -> [Meaning] {
        var meanings: [Meaning] = []
        guard let meaningEntities = meaningEntitiesSet.allObjects as? [MeaningEntity] else { return [] }
        
        for meaningEntity in meaningEntities {
            meanings.append(Meaning(partOfSpeech: meaningEntity.partOfSpeech, definitions: castDefenitionsSetToArray(defenitionEntitiesSet: meaningEntity.definitions ?? [])))
        }
        
        return meanings
    }
    
    private func castDefenitionsSetToArray(defenitionEntitiesSet: NSSet) -> [Definition] {
        var definitions: [Definition] = []
        guard let definitionEntities = defenitionEntitiesSet.allObjects as? [DefinitionEntity] else { return [] }
        
        for definitionEntity in definitionEntities {
            definitions.append(Definition(definition: definitionEntity.definition, example: definitionEntity.example, synonyms: definitionEntity.synonyms, antonyms: definitionEntity.antonyms))
        }
        
        return definitions
    }
    
    private func castPhoneticsSetToArray(phoneticEntitiesSet: NSSet) -> [Phonetic] {
        var phonetics: [Phonetic] = []
        guard let phoneticEntities = phoneticEntitiesSet.allObjects as? [PhoneticEntity] else { return [] }
        
        for phoneticEntity in phoneticEntities {
            phonetics.append(Phonetic(text: phoneticEntity.text, audio: phoneticEntity.audio))
        }
        
        return phonetics
    }
}
