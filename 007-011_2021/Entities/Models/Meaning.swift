//
//  Meaning.swift
//  007-011_2021
//
//  Created by Рустем on 15.12.2021.
//

import Foundation

struct Meaning: Codable {
    
    // MARK: - Properties
    
    let partOfSpeech: String
    let definitions: [Definition]
}
