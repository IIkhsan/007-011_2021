//
//  Word.swift
//  007-011_2021
//
//  Created by Даниил Багаутдинов on 23.11.2021.
//

import Foundation

struct Word: Codable {
    let word: String
    let phonetics: [Phonetic]
    let meanings: [Meaning]
}
