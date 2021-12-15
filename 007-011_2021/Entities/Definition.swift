//
//  Definition.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 15.12.2021.
//

import Foundation

struct Definition: Codable {
    let definition: String
    let example: String?
    let synonyms, antonyms: [String]
}
