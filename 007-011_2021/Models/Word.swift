//
//  Word.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//

import Foundation

struct Word: Codable {
    let word: String
    let phonetic: String?
    let meaning: String?
    let phonetics: [Phonetics]
    let meanings: [Meanings]
}
