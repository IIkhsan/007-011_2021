//
//  WordResponseModel.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 08.12.2021.
//

import Foundation

struct WordResponseModel: Codable {
    let word: String
    let phonetics: [PhoneticsResponseModel]
    let meanings: [MeaningsResponseModel]
}
