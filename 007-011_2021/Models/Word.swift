//
//  Word.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 12.12.2021.
//

import Foundation

struct Word: Codable {
    
    let word: String?
    let phonetic: String?
    let phonetics: [Phonetic]?
    let origin: String?
    let meanings: [Meaning]?
    
    enum CodingKeys: String, CodingKey {
        case word = "word"
        case phonetic = "phonetic"
        case phonetics = "phonetics"
        case origin = "origin"
        case meanings = "meanings"
    }
}
