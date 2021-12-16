//
//  Enum.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 16.12.2021.
//

import Foundation

enum ObtainWordsResult {
    case success(words: [Word])
    case failure(error: Error)
}
