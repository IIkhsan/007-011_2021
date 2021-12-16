//
//  Definition.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 12.12.2021.
//

import Foundation

struct Definition: Codable {
    
    let definition: String?
    let example: String?
    let synonyms: [String]?
    let antonyms: [String]?
    
    enum CodingKeys: String, CodingKey {
        case definition = "definition"
        case example = "example"
        case synonyms = "synonyms"
        case antonyms = "antonyms"
    }
}
