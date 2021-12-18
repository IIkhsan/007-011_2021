//
//  Definition.swift
//  007-011_2021
//
//  Created by Рустем on 15.12.2021.
//

import Foundation

struct Definition: Codable {
    
    // MARK: - Properties
    
    let definition: String
    let example: String?
    let synonyms: [String]?
    let antonyms: [String]?
}
