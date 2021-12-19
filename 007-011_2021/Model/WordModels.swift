//
//  Word.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import Foundation

// MARK: - WordElement
struct WordElement: Codable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetic]?
    let origin: String?
    let meanings: [Meaning]?
}

// MARK: - Meaning
struct Meaning: Codable {
    let partOfSpeech: String?
    let definitions: [Definition]?
}

// MARK: - Definition
struct Definition: Codable {
    let definition: String?
    let example: String?
    let synonyms, antonyms: [String]?
}

// MARK: - Phonetic
struct Phonetic: Codable {
    let text: String?
    let audio: String?
}

typealias Word = WordElement
