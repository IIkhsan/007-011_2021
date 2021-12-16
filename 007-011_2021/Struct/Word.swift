//
//  Word.swift
//  007-011_2021
//
//  Created by Илья Желтиков on 15.12.2021.
//

import Foundation

struct Word: Codable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetics]?
    let origin: String?
    let meanings: [Meanings]?
}
