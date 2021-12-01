//
//  WordInteractor.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 29.11.2021.
//

import Foundation
class WordServicesInteractor {
    
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
        let wordEntity = transfer.transferWordEntityToElement(word: word)
        persistableService.deleteSavedWord(wordEntity: wordEntity)
    }
    
    func saveWord(word: Word) {
        let wordEntity = transfer.transferWordEntityToElement(word: word)
        persistableService.saveWord(wordEntity: wordEntity)
    }
    
    func fetchWord(word: String, completion: @escaping (Result<Word, Error>) -> Void) {
        return networkService.fetchWord(word: word, completion: completion)
    }
}
