//
//  Word.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 20.11.2021.
//

import Foundation

struct Word: Codable {
  let name: String
  let phonetic: String?
  let phonetics: [Phonetic]
  let meanings: [Meaning]
  
  init(_ wordEntity: WordEntity) {
    name = wordEntity.name
    phonetic = wordEntity.phonetic
    guard let phonetic = wordEntity.phonetics.allObjects as? [Phonetic] else {
      self.phonetics = []
      meanings = []
      return
    }
    self.phonetics = phonetic
    guard let meanings = wordEntity.meanings.allObjects as? [Meaning] else {
      self.meanings = []
      return
    }
    self.meanings = meanings
  }
  
  init(name: String, phonetic: String?, phonetics: [Phonetic], meanings: [Meaning]) {
    self.name = name
    self.phonetic = phonetic
    self.phonetics = phonetics
    self.meanings = meanings
  }
  
  enum CodingKeys: String, CodingKey {
    case name = "word"
    case phonetic = "phonetic"
    case phonetics = "phonetics"
    case meanings = "meanings"
  }
}

struct Phonetic: Codable {
  let text: String
  let audio: String?
  
  init (_ phoneticEntity: PhoneticEntity) {
    text = phoneticEntity.name
    audio = phoneticEntity.audio
  }
  
  init(text: String, audio: String?) {
    self.text = text
    self.audio = audio
  }
  
  enum CodingKeys: String, CodingKey {
    case text = "text"
    case audio = "audio"
  }
}

struct Meaning: Codable {
  let partOfSpeech: String
  let definitions: [Definition]
  
  init(_ meaningEntity: MeaningEntity) {
    partOfSpeech = meaningEntity.partOfSpeach
    guard let definitions = meaningEntity.definitions.allObjects as? [Definition] else {
      self.definitions = []
      return
    }
    self.definitions = definitions
  }
  
  init(partOfSpeach: String, definitions: [Definition]) {
    self.partOfSpeech = partOfSpeach
    self.definitions = definitions
  }
  
  enum CodingKeys: String, CodingKey {
    case partOfSpeech = "partOfSpeech"
    case definitions = "definitions"
  }
}

struct Definition: Codable {
  let definition: String
  let example: String?
  let synonyms: [String]
  let antonyms: [String]
  
  init(_ definitionEntity: DefinitionEntity) {
    definition = definitionEntity.definition
    example = definitionEntity.example
    synonyms = definitionEntity.synonyms
    antonyms = definitionEntity.antonyms
  }
  
  init(definition: String, example: String, synonyms: [String], antonyms: [String]) {
    self.definition = definition
    self.example = example
    self.synonyms = synonyms
    self.antonyms = antonyms
  }
  
  enum CodingKeys: String, CodingKey {
    case definition = "definition"
    case example = "example"
    case synonyms = "synonyms"
    case antonyms = "antonyms"
  }
}
