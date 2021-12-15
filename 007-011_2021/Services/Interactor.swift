//
//  Interactor.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//

import Foundation

class Interactor {
    
    // MARK: - Dependencies
     private let networkService: NetworkService = NetworkService.shared
     private let persistableService: PersistableService = PersistableService.shared
    static let shared = Interactor()
    
    func getWords(request: String, completion: @escaping (Result<[Word], Error>) -> Void) {
        networkService.getWord(request: request, completion: completion)
    }
    
    func fetchWords() -> [Word] {
        return persistableService.fetchWords()
    }
    
    func deleteWord(_ word: String) {
        persistableService.deleteWord(word: word)
    }
}
