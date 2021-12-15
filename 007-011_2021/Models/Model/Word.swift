//
//  Word.swift
//  007-011_2021
//
//  Created by Marat Giniyatov on 12.12.2021.
//

import Foundation

struct Word: Codable {
    let word: String
    let origin: String?
    let phonetics: [Phonetic]
    let meanings: [Meaning]
}
