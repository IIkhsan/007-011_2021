//
//  PersistableServiceInteractor.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 10.12.2021.
//

import Foundation

class PersistableServiceInteractor {
    //MARK: -Singleton
    static let shared = PersistableServiceInteractor()
    
    //MARK: - Interactor's properties
    private let persistableService = PersistableService.shared
    
    //MARK: - Interactor's methods
    func fetchWords() -> [WordResponseModel] {
        return persistableService.fetchAllWords()
    }
    
    func saveWord(_ word: WordResponseModel) {
        persistableService.saveWord(word: word)
    }
    
    func removeWord(_ word: String) {
        persistableService.removeWord(word: word)
    }
}
