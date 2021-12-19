//
//  SearchWordsModel.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import Foundation

class SearchWordsModel {
    
    //MARK: - Properties
    let interactor = WordServicesInteractor.instance
    var words: [Word]? = nil
    
    //MARK: - Public functions
    public func fetchWords(word: String, completion: @escaping () -> Void) {
        interactor.fetchWords(word: word, completion: { [weak self] result in
            switch result {
            case .failure(_):
                self?.words = nil
            case .success(let fetchedWords):
                self?.words = fetchedWords
                completion()
            }
        })
    }
    
    public func saveWord(word: Word) {
        interactor.saveWord(word: word)
    }
}
