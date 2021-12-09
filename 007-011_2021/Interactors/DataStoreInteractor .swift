//
//  DataStoreInteractor .swift
//  007-011_2021
//
//  Created by Artem Kalugin on 09.12.2021.
//

import Foundation

class DataStoreInteractor {
    // private properties
    private let dataStoreService = DataStoreService()
    
    func saveWord(word: Word) {
        dataStoreService.saveWord(word: word)
    }
    
    func getAllWords() -> [Word] {
        let wordEntities = dataStoreService.getAllWords()
        var words: [Word] = []
        
        for wordEntity in wordEntities {
            words.append(Word(word: wordEntity.word ?? "", phonetics: castPhoneticsSetToArray(phoneticEntitiesSet: wordEntity.phonetics ?? []), meanings: castMeaningsSetToArray(meaningEntitiesSet: wordEntity.meanings ?? [])))
        }
        
        return words
    }
    
    func isContainsWord(word: Word) -> Bool {
        return dataStoreService.isContainsWord(word: word)
    }
    
    private func castMeaningsSetToArray(meaningEntitiesSet: NSSet) -> [Meaning] {
        var meanings: [Meaning] = []
        guard let meaningEntities = meaningEntitiesSet.allObjects as? [MeaningEntity] else { return [] }
        
        for meaningEntity in meaningEntities {
            meanings.append(Meaning(partOfSpeech: meaningEntity.partOfSpeech, definitions: castDefenitionsSetToArray(defenitionEntitiesSet: meaningEntity.definitions ?? [])))
        }
        
        return meanings
    }
    
    private func castDefenitionsSetToArray(defenitionEntitiesSet: NSSet) -> [Definition] {
        var definitions: [Definition] = []
        guard let definitionEntities = defenitionEntitiesSet.allObjects as? [DefinitionEntity] else { return [] }
        
        for definitionEntity in definitionEntities {
            definitions.append(Definition(definition: definitionEntity.definition, example: definitionEntity.example))
        }
        
        return definitions
    }
    
    private func castPhoneticsSetToArray(phoneticEntitiesSet: NSSet) -> [Phonetic] {
        var phonetics: [Phonetic] = []
        guard let phoneticEntities = phoneticEntitiesSet.allObjects as? [PhoneticEntity] else { return [] }
        
        for phoneticEntity in phoneticEntities {
            phonetics.append(Phonetic(text: phoneticEntity.text, audio: phoneticEntity.audio))
        }
        
        return phonetics
    }
}
