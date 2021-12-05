//
//  SavedWordsModel.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 02.12.2021.
//

import Foundation
class SavedWordsModel {
    
    //MARK: - Properties
    let interactor = WordServicesInteractor()
    lazy var storedWords = {
         interactor.getAllStoredWords()
    }()
    lazy var filtered: [Word] = {
        return self.storedWords
    }()
    
    //MARK: - Public functions
    func deleteWord(word: Word) {
        interactor.deleteSavedWord(word: word)
    }
    
    func updateWords() {
        storedWords = interactor.getAllStoredWords()
        filtered = storedWords
    }
}
