//
//  WordEntity+Converters.swift
//  007-011_2021
//
//  Created by Evans Owamoyo on 12.12.2021.
//

import Foundation

extension WordEntity {
    
    // MARK: - Entity to Model converter
    func toWord() -> Word {
        // get word meanings and convert it's nested classes
        let wordMeanings: [Meaning] = nsSetToArray(set: meanings, type: MeaningEntity.self)
            .map { meaningEntity in
                let definitions: [Definition] = nsSetToArray(set: meaningEntity.definitions, type: DefinitionEntity.self)
                    .map({ definitionEntity in
                        let syn = nsSetToArray(set: definitionEntity.synonyms, type: SynonymEntity.self)
                        let ant = nsSetToArray(set: definitionEntity.antonyms, type: AntonymEntity.self)
                        return Definition(definition: definitionEntity.definition,
                                          example: definitionEntity.example,
                                          synonyms: syn.map { $0.value! },
                                          antonyms: ant.map { $0.value! })
                    })
                
                return Meaning(partOfSpeech: meaningEntity.partOfSpeech, definitions: definitions)
            }
        
        // convert phonetics
        let wordPhonetics: [Phonetics] = nsSetToArray(set: phonetics, type: PhoneticEntity.self)
            .map { Phonetics(text: $0.text, audio: $0.audio) }
        
        // return result
        return Word(word: word!,
                    phonetic: phonetic,
                    phonetics: wordPhonetics,
                    origin: origin,
                    meanings: wordMeanings)
    }
    
    // MARK: - private functions
    /// converts NSSet to [Entity]
    private func nsSetToArray<T>(set: NSSet?, type: T.Type) -> [T] {
        return set?.allObjects as? [T] ?? []
    }
}
