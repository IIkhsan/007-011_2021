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
        var meanings: [Meaning] = []
//        for meaning in wordEntity.meanings {
//            meanings.append(transferMeaningEntity(meaningEntity: meaning))
//        }
        var phonetics: [Phonetic] = []
//        for phonetic in wordEntity.phonetics {
//            phonetics.append(transferPhoneticEntity(phoneticEntity: phonetic))
//        }
        return Word(word: word, phonetic: phonetic, phonetics: phonetics, origin: origin, meanings: meanings)
    }
}
