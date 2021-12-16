//
//  Phonetic.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 12.12.2021.
//

import Foundation

struct Phonetic: Codable {
    
    let text: String?
    let audio: String?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case audio = "audio"
    }
}
