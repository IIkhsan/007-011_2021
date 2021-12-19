//
//  WordServicesInteractor.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import Foundation
class WordServicesInteractor {
    
    static let instance = WordServicesInteractor()
    
    //MARK: - Properties
    let persistableService: PersistableService = PersistableService.shared
    let networkService: NetworkService = NetworkService.shared
    
    //MARK: - Public functions
    func getSavedWordsContaining(word: String) -> [Word] {
        let wordEntities = persistableService.getSavedWordsContaining(word: word)
        var result: [Word] = []
        for entity in wordEntities {
            result.append(transferWordEntityToElement(wordEntity: entity))
        }
        return result
    }
    
    func deleteSavedWord(word: Word) {
        persistableService.deleteWord(word)
    }
    
    func saveWord(word: Word) {
        persistableService.saveWord(word)
    }
    
    func fetchWords(word: String, completion: @escaping (Result<[Word], Error>) -> Void) {
        return networkService.fetchWords(word: word, completion: completion)
    }
    
    func getAllStoredWords() -> [Word] {
        let words = persistableService.getAllSavedWords()
        var result: [Word] = []
        for word in words {
            result.append(transferWordEntityToElement(wordEntity: word))
        }
        return result
    }
    
    public func transferWordEntityToElement(wordEntity: WordEntity) -> Word {
        let word = wordEntity.word
        let origin = wordEntity.origin
        let phonetic = wordEntity.phonetic ?? ""
        let meanings: [Meaning] = castMeaningsSetToArray(meaningEntitiesSet: wordEntity.meanings ?? NSSet(array:[]))
        let phonetics: [Phonetic] = castPhoneticsSetToArray(phoneticEntitiesSet: wordEntity.phonetics ?? NSSet(array:[]))

        return Word(word: word, phonetic: phonetic, phonetics: phonetics, origin: origin, meanings: meanings)
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
