//
//  Word.swift
//  007-011_2021
//
//  Created by Рустем on 15.12.2021.
//

import Foundation

struct Word: Codable {
    
    // MARK: - Properties
    
    let word: String
    let origin: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]
    
}
