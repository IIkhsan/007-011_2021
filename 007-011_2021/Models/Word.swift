//
//  DictionaryNetworkModels.swift
//  007-011_2021
//
//  Created by Evans Owamoyo on 12.12.2021.
//

import Foundation


struct Word: Decodable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetics]
    let origin: String?
    let meanings: [Meaning]
}

struct Phonetics: Decodable {
    let text: String?
    let audio: String?
}

struct Meaning: Decodable {
    let partOfSpeech: String?
    let definitions: [Definition]
}

struct Definition: Decodable {
    let definition: String?
    let example: String?
    let synonyms: [String]
    let antonyms: [String]
}

