//
//  Word.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 21.11.2021.
//

import Foundation

struct Word: Codable {
    // properties 
    let word: String
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
}
