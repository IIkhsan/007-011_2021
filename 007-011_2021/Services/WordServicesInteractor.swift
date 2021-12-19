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
    lazy var transfer: WordFormatTransfer = {
        let transfer = WordFormatTransfer(context: persistableService.context)
        return transfer
    }()
    
    //MARK: - Public functions
    func getSavedWordsContaining(word: String) -> [Word] {
        let wordEntities = persistableService.getSavedWordsContaining(word: word)
        var result: [Word] = []
        for entity in wordEntities {
            result.append(transfer.transferWordEntityToElement(wordEntity: entity))
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
            result.append(transfer.transferWordEntityToElement(wordEntity: word))
        }
        return result
    }
}
