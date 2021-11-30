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
    func getSavedWord(word: String) -> Word {
        let wordEntity = persistableService.getSavedWord(word: word)
        return transfer.transferWordEntityToElement(wordEntity: wordEntity)
    }
    
    func deleteSavedWord(word: Word) {
        let wordEntity = transfer.transferWordEntityToElement(word: word)
        persistableService.deleteSavedWord(wordEntity: wordEntity)
    }
    
    func saveWord(word: Word) {
        let wordEntity = transfer.transferWordEntityToElement(word: word)
        persistableService.saveWord(wordEntity: wordEntity)
    }
}
