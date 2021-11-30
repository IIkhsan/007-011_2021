//
//  PersistableServiceImpl.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 21.11.2021.
//

import Foundation
import CoreData

protocol PersistableService {
  func readWords() -> [Word]
  func saveWord(_ word: Word)
  func deleteWord(_ word: Word)
  func didUserSawOnboarding() -> Bool
  func setStatusOfOnboarding(bool: Bool)
}

final class PersistableServiceImpl: PersistableService {
  // MARK: - Properties
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Model")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  private lazy var viewContext = persistentContainer.viewContext
  
  private let userDefaults = UserDefaults.standard
  private let onboardingName = "Onboarding"
  
  // Shared
  static let shared: PersistableService = PersistableServiceImpl()
  
  // MARK: - CRUD
  private func saveContext() {
    if viewContext.hasChanges {
      do {
        try viewContext.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func readWords() -> [Word] {
    let fetchRequest = WordEntity.fetchRequest()
    
    guard let wordsEntities = try? viewContext.fetch(fetchRequest) else { return [] }
    var words: [Word] = []
    
    for element in wordsEntities {
      words.append(Word(element))
    }
    return words
  }
  
  func saveWord(_ word: Word) {
    let wordEntity = WordEntity(context: viewContext, word)
    
    for phonetic in word.phonetics {
      let phonteicEntity = PhoneticEntity(context: viewContext, phonetic)
      wordEntity.addToPhonetics(phonteicEntity)
    }
    
    for meaning in word.meanings {
      let meaningEntity = MeaningEntity(context: viewContext, meaning)
      for definition in meaning.definitions {
        let definitionEntity = DefinitionEntity(context: viewContext, definition)
        meaningEntity.addToDefinitions(definitionEntity)
      }
      wordEntity.addToMeanings(meaningEntity)
    }
    saveContext()
  }
  
  func deleteWord(_ word: Word) {
    let fetchRequest = WordEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "name = %@", word.name)
    
    guard let wordsEntities = try? viewContext.fetch(fetchRequest), !wordsEntities.isEmpty else { return }
    
    viewContext.delete(wordsEntities.first!)
    saveContext()
  }
  
  // MARK: - Onboarding methods
  func didUserSawOnboarding() -> Bool {
    return userDefaults.bool(forKey: onboardingName)
  }
  
  func setStatusOfOnboarding(bool: Bool) {
    userDefaults.set(bool, forKey: onboardingName)
  }
}
