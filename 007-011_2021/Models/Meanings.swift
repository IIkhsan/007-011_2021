//
//  Meanings.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//

import Foundation

struct Meanings: Codable {
    let partOfSpeech: String
    let definitions: [Definitions]
    let word: [Word]
}
