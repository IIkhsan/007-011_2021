//
//  SearchWordsModel.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 04.12.2021.
//

import Foundation

class SearchWordsModel {
    
    //MARK: - Properties
    let interactor = WordServicesInteractor()
    var word: Word? = nil
    
    //MARK: - Public functions
    public func fetchWord(word: String, completion: @escaping () -> Void) {
        interactor.fetchWord(word: word, completion: { [weak self] result in
            switch result {
            case .failure(_):
                self?.word = nil
            case .success(let fetchedWord):
                self?.word = fetchedWord
                completion()
            }
        })
    }
    
    public func saveWord(word: Word) {
        interactor.saveWord(word: word)
    }
}
