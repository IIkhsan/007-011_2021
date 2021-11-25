//
//  Phonetics.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//

import Foundation

struct Phonetics: Codable {
    let audio: String
    let text: String
    let word: [Word]
}
