//
//  Word.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 21.11.2021.
//

import Foundation

// MARK: - WordElement
struct WordElement: Codable {
    let word, phonetic: String
    let phonetics: [Phonetic]
    let origin: String?
    let meanings: [Meaning]
}

typealias Word = WordElement
