//
//  WordFormatService.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import Foundation
import CoreData

class WordFormatTransfer {
    
    //MARK: - Properties
    let context: NSManagedObjectContext
    let persistableService = PersistableService.shared
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    //MARK: - Public functions
    
    public func transferWordEntityToElement(wordEntity: WordEntity) -> Word {
        let word = wordEntity.word
        let origin = wordEntity.origin
        let phonetic = wordEntity.phonetic ?? ""
        var meanings: [Meaning] = []
//        for meaning in wordEntity.meanings {
//            meanings.append(transferMeaningEntity(meaningEntity: meaning))
//        }
        var phonetics: [Phonetic] = []
//        for phonetic in wordEntity.phonetics {
//            phonetics.append(transferPhoneticEntity(phoneticEntity: phonetic))
//        }
        return Word(word: word, phonetic: phonetic, phonetics: phonetics, origin: origin, meanings: meanings)
    }
    
    //MARK: - Private functions
    
    
}
