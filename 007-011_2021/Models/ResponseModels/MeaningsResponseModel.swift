//
//  MeaningsResponseModel.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 08.12.2021.
//

import Foundation

struct MeaningsResponseModel: Codable {
    let partOfSpeech: String?
    let definitions: [DefinitionsResponseModel]
}
