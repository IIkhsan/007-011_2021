//
//  Meaning.swift
//  007-011_2021
//
//  Created by Даниил Багаутдинов on 23.11.2021.
//

import Foundation

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
}
