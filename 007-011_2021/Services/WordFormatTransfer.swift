//
//  WordFormatTransfer.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 30.11.2021.
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
    public func transferWordEntityToElement(word: Word) -> WordEntity {
        let wordStored = persistableService.getSavedWord(word: word.word)
        if wordStored != nil {
            return wordStored!
        }
        let wordEntity = WordEntity(context: context)
        wordEntity.word = word.word
        wordEntity.origin = word.origin
        wordEntity.phonetic = word.phonetic
        let meanings = word.meanings
        for meaning in meanings {
            wordEntity.addToMeanings(transferMeanings(meaning: meaning))
        }
        let phonetics = word.phonetics
        for phonetics in phonetics {
            wordEntity.addToPhonetics(transferPhonetic(phonetic: phonetics))
        }
        return wordEntity
    }
    
    public func transferWordEntityToElement(wordEntity: WordEntity) -> Word {
        let word = wordEntity.word ?? ""
        let origin = wordEntity.origin
        let phonetic = wordEntity.phonetic ?? ""
        var meanings: [Meaning] = []
        for meaning in wordEntity.meanings ?? [] {
            meanings.append(transferMeaningEntity(meaningEntity: meaning))
        }
        var phonetics: [Phonetic] = []
        for phonetic in wordEntity.phonetics ?? [] {
            phonetics.append(transferPhoneticEntity(phoneticEntity: phonetic))
        }
        return Word(word: word, phonetic: phonetic, phonetics: phonetics, origin: origin, meanings: meanings)
    }
    
    //MARK: - Private functions
    private func transferMeanings(meaning: Meaning) -> MeaningEntity {
        let meaningEntity = MeaningEntity(context: context)
        meaningEntity.partOfSpeech = meaning.partOfSpeech
        let definitions = meaning.definitions
        for definition in definitions {
            meaningEntity.addToDefinitions(transferDefinition(definition: definition))
        }
        return meaningEntity
    }
    
    private func transferDefinition(definition: Definition) -> DefinitionEntity {
        let definitionEntity = DefinitionEntity(context: context)
        definitionEntity.definition = definition.definition
        let synonyms = definition.synonyms
        for synonym in synonyms {
            definitionEntity.addToSynonyms(transferSynonym(synonym: synonym))
        }
        let antonyms = definition.antonyms
        for antonym in antonyms {
            definitionEntity.addToAntonyms(transferAntonyms(antonym: antonym))
        }
        return definitionEntity
    }
    
    private func transferAntonyms(antonym: String) -> AntonymEntity {
        let antonymEntity = AntonymEntity(context: context)
        antonymEntity.antonym = antonym
        return antonymEntity
    }
    
    private func transferSynonym(synonym: String) -> SynonymEntity  {
        let synonymEntity = SynonymEntity(context: context)
        synonymEntity.synonym = synonym
        return synonymEntity
    }
    
    private func transferPhonetic(phonetic: Phonetic) -> PhoneticEntity {
        let phoneticEntity = PhoneticEntity(context: context)
        phoneticEntity.audio = phonetic.audio
        phoneticEntity.text = phonetic.text
        return phoneticEntity
    }
    
    private func transferMeaningEntity(meaningEntity: MeaningEntity) -> Meaning {
        let partOfSpeech = meaningEntity.partOfSpeech ?? ""
        var definitions: [Definition] = []
        for definition in meaningEntity.definitions ?? [] {
            definitions.append(transferDefinitionEntity(definitionEntity: definition))
        }
        return Meaning(partOfSpeech: partOfSpeech, definitions: definitions)
    }
    
    private func transferDefinitionEntity(definitionEntity: DefinitionEntity) -> Definition {
        let definition = definitionEntity.definition ?? ""
        let example = definitionEntity.example
        var synonyms: [String] = []
        for synonym in definitionEntity.synonyms ?? [] {
            synonyms.append(synonym.synonym ?? "")
        }
        var antonyms: [String] = []
        for antonym in definitionEntity.antonyms ?? [] {
            antonyms.append(antonym.antonym ?? "")
        }
        return Definition(definition: definition, example: example, synonyms: synonyms, antonyms: antonyms)
    }
    
    private func transferPhoneticEntity(phoneticEntity: PhoneticEntity) -> Phonetic {
        let text = phoneticEntity.text ?? ""
        let audio = phoneticEntity.audio
        return Phonetic(text: text, audio: audio)
    }
}
