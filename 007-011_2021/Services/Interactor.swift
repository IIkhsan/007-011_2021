//
//  Interactor.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 23.11.2021.
//

import Foundation

protocol Interactor: NetworkService, PersistableService {

}

final class InteractorImpl: Interactor {
  // MARK: - Dependencies
  private let networkService: NetworkService = NetworkServiceImpl.shared
  private let persistableService: PersistableService = PersistableServiceImpl.shared
  
  // MARK: - NetworkService
  func getWords(_ word: String, completion: @escaping ((Result<[Word], Error>) -> Void)) {
    networkService.getWords(word, completion: completion)
  }
  
  // MARK: - PersistableService
  func readWords() -> [Word] {
    return persistableService.readWords()
  }
  
  func saveWord(_ word: Word) {
    persistableService.saveWord(word)
  }
  
  func deleteWord(_ word: Word) {
    persistableService.deleteWord(word)
  }
  
  func didUserSawOnboarding() -> Bool {
    return persistableService.didUserSawOnboarding()
  }
  
  func setStatusOfOnboarding(bool: Bool) {
    persistableService.setStatusOfOnboarding(bool: bool)
  }
}
