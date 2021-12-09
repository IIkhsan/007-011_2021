//
//  Word.swift
//  007-011_2021
//
//  Created by Тимур Миргалиев on 21.11.2021.
//

import Foundation

struct Word: Codable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetics]?
    let origin: String?
    let meanings: [Meanings]?
} 
