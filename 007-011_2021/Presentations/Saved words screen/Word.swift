//
//  Word.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 20.11.2021.
//

import Foundation

struct Word {
    let name: String
    let phonetic: String?
    let phonetics: [Phonetic]
    let meanings: [Meaning]
}

struct Phonetic {
    let text: String
    let audio: String?
}

struct Meaning {
    let partOfSpeach: String
    let definitions: [Definition]
}

struct Definition {
    let definition: String
    let example: String
    let synonyms: [String]
    let antonyms: [String]
}
