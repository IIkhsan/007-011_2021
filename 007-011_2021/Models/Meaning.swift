//
//  Meaning.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 12.12.2021.
//

import Foundation

struct Meaning: Codable {
    
    let partOfSpeech: String?
    let definitions: [Definition]?
    
    enum CodingKeys: String, CodingKey {
        case partOfSpeech = "partOfSpeech"
        case definitions = "definitions"
    }
}
